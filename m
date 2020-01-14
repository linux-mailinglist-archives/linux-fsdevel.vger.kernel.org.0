Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A68913B312
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 20:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbgANTji (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 14:39:38 -0500
Received: from mga01.intel.com ([192.55.52.88]:52361 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgANTjh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 14:39:37 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 11:39:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,320,1574150400"; 
   d="sh'?scan'208";a="397619827"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga005.jf.intel.com with ESMTP; 14 Jan 2020 11:39:36 -0800
Date:   Tue, 14 Jan 2020 11:39:36 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH V2 10/12] fs/xfs: Fix truncate up
Message-ID: <20200114193934.GA23311@iweiny-DESK2.sc.intel.com>
References: <20200110192942.25021-1-ira.weiny@intel.com>
 <20200110192942.25021-11-ira.weiny@intel.com>
 <20200113222755.GP8247@magnolia>
 <20200114004047.GC29860@iweiny-DESK2.sc.intel.com>
 <20200114011407.GT8247@magnolia>
 <20200114190057.GB7871@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <20200114190057.GB7871@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 14, 2020 at 11:00:57AM -0800, 'Ira Weiny' wrote:
> On Mon, Jan 13, 2020 at 05:14:07PM -0800, Darrick J. Wong wrote:
> > On Mon, Jan 13, 2020 at 04:40:47PM -0800, Ira Weiny wrote:
> > > On Mon, Jan 13, 2020 at 02:27:55PM -0800, Darrick J. Wong wrote:
> > > > On Fri, Jan 10, 2020 at 11:29:40AM -0800, ira.weiny@intel.com wrote:
> > > > > From: Ira Weiny <ira.weiny@intel.com>

[snip]

> 
> > 
> > > But as I said in the cover I am not 100% sure of
> > > this fix.
> > 
> > > From what I can tell xfs_ioctl_setattr_dax_invalidate() should invalidate the
> > > mappings and the page cache and the traces I have indicate that the DAX mode
> > > is not changing or was properly held off.
> > 
> > Hmm, that implies the invalidation didn't work.  Can you find a way to
> > report the contents of the page cache after the dax mode change
> > invalidation fails?  I wonder if this is something dorky like rounding
> > down such that the EOF page doesn't actually get invalidated?
> > 
> > Hmm, no, xfs_ioctl_setattr_dax_invalidate should be nuking all the
> > pages... do you have a quick reproducer?
> 
> I thought I did...
> 
> What I have done is take this patch:
> 
> https://www.spinics.net/lists/fstests/msg13313.html
> 
> and put [run_fsx ""] in a loop... (diff below) And without this truncate fix
> patch it was failing in about 5 - 10 iterations.  But I'm running it right now
> and it has gone for 30+...  :-(

Ok...  perhaps this is a qemu problem?  In qemu I had a slightly different
script; 'test-suite.sh' (attached).  This was copied to create the xfstest I
sent.  Without this 'fix truncate patch I get something like the following
after in just a few iterations.

...

   *** run 'fsx ' racing with setting/clearing the DAX flag
   *** run 'fsx ' racing with setting/clearing the DAX flag
FAILED: fsx exited with status : 205
        see trace_output
zero_range to largest ever: 0x19867
truncating to largest ever: 0x3fb6d
zero_range to largest ever: 0x40000
Mapped Write: non-zero data past EOF (0x3ab88) page offset 0xb89 is 0xe71c
LOG DUMP (15817 total operations):
15818(202 mod 256): SKIPPED (no operation)
15819(203 mod 256): ZERO     0x2ae9f thru 0x3346c       (0x85ce bytes)
15820(204 mod 256): READ     0x3637 thru 0x91e6 (0x5bb0 bytes)
15821(205 mod 256): MAPREAD  0x38a80 thru 0x3d014       (0x4595 bytes)
15822(206 mod 256): INSERT 0x28000 thru 0x29fff (0x2000 bytes)

Ira

> 
> I am 90% confident that this series works for 100% of the use cases we have.  I
> think this is an existing bug which I've just managed to find.  And again I'm
> not comfortable with this patch either.  So I'm not trying to argue for it but
> I just don't know what could be wrong...
> 
> Ira
> 
> diff --git a/tests/generic/999 b/tests/generic/999
> index 6dd5529dbc65..929c20c6db04 100755
> --- a/tests/generic/999
> +++ b/tests/generic/999
> @@ -274,7 +274,9 @@ function run_fsx {
>         pid=""
>  }
>  
> -run_fsx ""
> +while [ 1 ]; do
> +       run_fsx ""
> +done
>  run_fsx "-A"
>  run_fsx "-Z -r 4096 -w 4096"
> 

--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="test-suite.sh"

#!/bin/bash

#
# Run suite of tests for feature
#

mnt_pt=/mnt/pmem

function mount_no_dax {
	umount $mnt_pt
	mount /dev/pmem0 $mnt_pt
}

function mount_dax {
	umount $mnt_pt
	mount -o dax /dev/pmem0 $mnt_pt
}

# test set up
if [ ! -d /mnt/pmem ]; then
	echo ""
	echo "     Setting up FS DAX"
	echo ""

	ndctl create-namespace -e namespace0.0 -f --mode=fsdax
	#mkfs.ext4 /dev/pmem0
	mkfs.xfs -f /dev/pmem0
	mkdir -p /mnt/pmem
	mount_no_dax
fi

#if [ ! -c /dev/dax1.0 ]; then
#	echo ""
#	echo "     Setting up DEV DAX"
#	echo ""
#
#	ndctl create-namespace -f --mode=devdax --align=4096 -e namespace1.0
#fi

if [ "$1" == "--create-fs-only" ]; then
	exit 0
fi


test_file=/mnt/pmem/foo

function start_test {
	rm -f $test_file
	echo ""
	echo "     ***** START ${FUNCNAME[1]} *****"
}

function end_test {
	echo "     ***** END ${FUNCNAME[1]} *****"
	echo ""
	killall -9 rdma-fsdax
}

function expect_pass {
	echo -n "     ***** $2 : "
	if [ "$1" == "0" ]; then
		echo "PASSED"
	else
		echo "FAILED"
		exit 255
	fi
}

function expect_fail {
	echo -n "     ***** $2 : "
	if [ "$1" == "0" ]; then
		echo "FAILED"
		exit 255
	else
		echo "PASSED"
	fi
}


# test below here are not fully written yet.  Just ideas of what we should test
# for.

function check_phys_dax {
	xfs_io -c 'lsattr' $1 | awk -e '{ print $1 }' | grep 'x' &> /dev/null
	if [ "$?" != "0" ]; then
		echo "FAILED: Did NOT find DAX flag on $1"
		exit 255
	fi
}

function check_effective_dax {
	attr=`xfs_io -c 'statx -r' $1 | grep 'stat.attributes' | awk -e '{ print $3 }'`
	masked=$(( $attr & 0x2000 ))
	if [ "$masked" != "8192" ]; then
		echo "FAILED: Did NOT find VFS DAX flag on $1"
		exit 255
	fi
}

function check_phys_no_dax {
	xfs_io -c 'lsattr' $1 | awk -e '{ print $1 }' | grep 'x' &> /dev/null
	if [ "$?" == "0" ]; then
		echo "FAILED: Found DAX flag on $1"
		exit 255
	fi
}

function check_effective_no_dax {
	attr=`xfs_io -c 'statx -r' $1 | grep 'stat.attributes' | awk -e '{ print $3 }'`
	masked=$(( $attr & 0x2000 ))
	if [ "$masked" == "8192" ]; then
		echo "FAILED: Found VFS DAX flag on $1"
		exit 255
	fi
}

XFS_IO_PROG=xfs_io

TEST_DIR=/mnt/pmem

dax_dir=$TEST_DIR/dax-dir
dax_sub_dir=$TEST_DIR/dax-dir/dax-sub-dir
dax_inh_file=$dax_dir/dax-inh-file
dax_non_inh_file=$dax_dir/dax-non-inh-file
non_dax=$TEST_DIR/non-dax
dax_file=$TEST_DIR/dax-file
dax_file_copy=$TEST_DIR/dax-file-copy
dax_file_move=$TEST_DIR/dax-file-move
data_file=$TEST_DIR/data-file

function clean_up {
	echo "cleaning up..."
	rm -rf $TEST_DIR/*
}

clean_up

# Do double mount to have these special options.
mount_no_dax
touch $dax_file

if [ "$1" == "--chattr-only" ]; then
	for i in `seq 1 10000`; do
		xfs_io -c 'chattr +x' $dax_file
		xfs_io -c 'chattr -x' $dax_file
	done
	exit 0
fi

if [ "$1" == "--fsx-only" ]; then
	./fsx -R -W -N 100000 $dax_file
	head $dax_file.fsxlog
	exit 0
fi

if [ "$1" == "--fsx-aio-only" ]; then
	./fsx -R -W -A -N 100000 $dax_file
	head $dax_file.fsxlog
	exit 0
fi

# The below should be kept the same as xfstests

echo "   *** mount w/o dax flag."
mount_no_dax

echo "   *** mark dax-dir as dax enabled"
mkdir $dax_dir
xfs_io -c 'chattr +x' $dax_dir
check_phys_dax $dax_dir
check_effective_dax $dax_dir

echo "   *** check file inheritance"
touch $dax_inh_file
check_phys_dax $dax_inh_file
check_effective_dax $dax_inh_file

echo "   *** check directory inheritance"
mkdir $dax_sub_dir
check_phys_dax $dax_sub_dir
check_effective_dax $dax_sub_dir

echo "   *** check changing directory"
xfs_io -c 'chattr -x' $dax_dir
check_phys_no_dax $dax_dir
check_effective_no_dax $dax_dir

echo "   *** check non file inheritance"
touch $dax_non_inh_file
check_phys_no_dax $dax_non_inh_file
check_effective_no_dax $dax_non_inh_file

echo "   *** check that previous file stays enabled"
check_phys_dax $dax_inh_file
check_effective_dax $dax_inh_file

echo "   *** Reset the directory"
xfs_io -c 'chattr +x' $dax_dir
check_phys_dax $dax_dir
check_effective_dax $dax_dir


# check mount override
# ====================

echo "   *** Remount fs with mount flag"
mount_dax
touch $non_dax
check_phys_no_dax $non_dax
check_effective_dax $non_dax

echo "   *** Check for non-dax files to be dax with mount option"
check_effective_dax $dax_non_inh_file

echo "   *** check for file dax flag 'sticky-ness' after remount"
touch $dax_file
xfs_io -c 'chattr +x' $dax_file
check_phys_dax $dax_file
check_effective_dax $dax_file

echo "   *** remount w/o mount flag"
mount_no_dax
check_phys_dax $dax_file
check_effective_dax $dax_file

check_phys_no_dax $non_dax
check_effective_no_dax $non_dax


# Check non-zero file operations
# ==============================

echo "   *** file should change effective but page cache should be empty"
$XFS_IO_PROG -f -c "pwrite 0 10000" $data_file > /dev/null
xfs_io -c 'chattr +x' $data_file
check_phys_dax $data_file
check_effective_dax $data_file


# Check inheritance on cp, mv
# ===========================

echo "   *** check inheritance on cp, mv"
cp $non_dax $dax_dir/conv-dax
check_phys_dax $dax_dir/conv-dax
check_effective_dax $dax_dir/conv-dax

echo "   *** Moved files 'don't inherit'"
mv $non_dax $dax_dir/move-dax
check_phys_no_dax $dax_dir/move-dax
check_effective_no_dax $dax_dir/move-dax

# Check preservation of phys on cp, mv
# ====================================

mv $dax_file $dax_file_move
check_phys_dax $dax_file_move
check_effective_dax $dax_file_move

cp $dax_file_move $dax_file_copy
check_phys_no_dax $dax_file_copy
check_effective_no_dax $dax_file_copy


# Verify no mode changes on mmap
# ==============================

echo "   *** check no mode change when mmaped"

dd if=/dev/zero of=$dax_file bs=4096 count=10 > $tmp.log 2>&1

# set known state.
xfs_io -c 'chattr -x' $dax_file
check_phys_no_dax $dax_file
check_effective_no_dax $dax_file

python3 - << EOF > $tmp.log 2>&1 &
import mmap
import time
print ('mmaping "$dax_file"')
f=open("$dax_file", "r+b")
mm = mmap.mmap(f.fileno(), 0)
print ('mmaped "$dax_file"')
while True:
	time.sleep(1)
EOF
pid=$!

sleep 1

# attempt to should fail
xfs_io -c 'chattr +x' $dax_file > /dev/null 2>&1
check_phys_no_dax $dax_file
check_effective_no_dax $dax_file

kill -TERM $pid > /dev/null 2>&1
wait $pid > /dev/null 2>&1

# after mmap released should work
xfs_io -c 'chattr +x' $dax_file
check_phys_dax $dax_file
check_effective_dax $dax_file


# Finally run the test stolen from Christoph Hellwig to test changing the mode
# while performing a series of operations
# =============================================================================

function run_fsx {
	options=$1

	echo "   *** run 'fsx $options' racing with setting/clearing the DAX flag"
	./fsx $options -N 20000 $dax_file > $tmp.log 2>&1 &
	pid=$!

	if [ ! -n "$pid" ]; then
		echo "FAILED to start fsx"
		exit 255
	fi

	# NOTE: for some
	for i in `seq 1 500`; do
		xfs_io -c 'chattr +x' $dax_file > /dev/null 2>&1
		xfs_io -c 'chattr -x' $dax_file > /dev/null 2>&1
	done

	wait $pid
	status=$?
	if [ "$status" != "0" ]; then
		cat /sys/kernel/debug/tracing/trace > trace_output
		echo "FAILED: fsx exited with status : $status"
		echo "        see trace_output"
		head $dax_file.fsxlog
		exit $status
	fi
	pid=""
}

while [ 1 ]; do
	run_fsx ""
done
	run_fsx "-A"
	run_fsx "-Z -r 4096 -w 4096"

echo "   *** Check 'dump' and 'xfsdump'"
echo "      TBD"

echo "   *** PASSED!  All tests PASSED ***"
exit 0


--k+w/mQv8wyuph6w0--
