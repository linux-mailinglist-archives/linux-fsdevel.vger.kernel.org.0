Return-Path: <linux-fsdevel+bounces-7467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7880B825461
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 14:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C0381C21C96
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 13:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FA42D787;
	Fri,  5 Jan 2024 13:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ldi8gPtP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6082E3F1;
	Fri,  5 Jan 2024 13:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lXZ6dhmE/ICvc6we7INUfg+/UsVr/HBiAoyEO42qbxw=; b=ldi8gPtPJVmH9PdcSI9hE76OmP
	bSn24xnqUB/dIB3NWE1ZGvL1k9CyH/2/b5W1F/xMfNwPeQQB8PA61QIxM+nIJ5tkN5BPmEIKRdLf5
	AGGnnFACaQ/HDlLDCE1LCLhlSIWVcflkgdChZ+jbY5EcHxk2EqRdKTdDhSsU9gOj+PHEb8nLqdxhd
	nyO7BW9T/tc2hbvgNfhJN9et9ro64C9it0YlSwWohR/nGEl+9x4Tr/CneDxq+NYe75aC0dykUGEkD
	/kVD9g/WG/FB8exdmfKBXOKQA2+e97wKF1RCOKeizvhWR5ypDLW4jACYvZs77dCxU5RIdEuHKMR/1
	q/l2Rjyg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rLk4u-000FpH-Mk; Fri, 05 Jan 2024 13:17:36 +0000
Date: Fri, 5 Jan 2024 13:17:36 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Anna Schumaker <Anna.Schumaker@netapp.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Jeff Layton <jlayton@kernel.org>, Steve French <smfrench@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Christian Brauner <christian@brauner.io>, linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix oops in NFS
Message-ID: <ZZgBcJ7OAS7Ui6gi@casper.infradead.org>
References: <ZZeLAAf6qiieA5fy@casper.infradead.org>
 <2202548.1703245791@warthog.procyon.org.uk>
 <20231221230153.GA1607352@dev-arch.thelio-3990X>
 <20231221132400.1601991-1-dhowells@redhat.com>
 <20231221132400.1601991-38-dhowells@redhat.com>
 <2229136.1703246451@warthog.procyon.org.uk>
 <1094259.1704449575@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094259.1704449575@warthog.procyon.org.uk>

On Fri, Jan 05, 2024 at 10:12:55AM +0000, David Howells wrote:
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > This commit (100ccd18bb41 in linux-next 20240104) is bad for me.  After
> > it, running xfstests gives me first a bunch of errors along these lines:
> > 
> > 00004 depmod: ERROR: failed to load symbols from /lib/modules/6.7.0-rc7-00037-g100ccd18bb41/kernel/fs/gfs2/gfs2.ko: Exec format error
> > 00004 depmod: ERROR: failed to load symbols from /lib/modules/6.7.0-rc7-00037-g100ccd18bb41/kernel/fs/zonefs/zonefs.ko: Exec format error
> > 00004 depmod: ERROR: failed to load symbols from /lib/modules/6.7.0-rc7-00037-g100ccd18bb41/kernel/security/keys/encrypted-keys/encrypted-keys.ko: Exec format error
> > 
> > and then later:
> > 
> > 00016 generic/001       run fstests generic/001 at 2024-01-05 04:50:46
> > 00017 [not run] this test requires a valid $TEST_DEV
> > 00017 generic/002       run fstests generic/002 at 2024-01-05 04:50:46
> > 00017 [not run] this test requires a valid $TEST_DEV
> > 00017 generic/003       run fstests generic/003 at 2024-01-05 04:50:47
> > 00018 [not run] this test requires a valid $SCRATCH_DEV
> > ...
> > 
> > so I think that's page cache corruption of some kind.
> 
> Is that being run on NFS?  Is /lib on NFS?

No NFS involvement; this is supposed to be an XFS test ...

/dev/sda on / type ext4 (rw,relatime)
host on /host type 9p (rw,relatime,access=client,trans=virtio)
/dev/sdb on /mnt/test type xfs (rw,relatime,attr2,inode64,logbufs=8,logbsize=32k,noquota)

CONFIG_NETFS_SUPPORT=y
# CONFIG_NETFS_STATS is not set
# CONFIG_FSCACHE is not set
CONFIG_NETWORK_FILESYSTEMS=y
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
# CONFIG_CEPH_FS is not set
# CONFIG_CIFS is not set
# CONFIG_SMB_SERVER is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_9P_FS=y
# CONFIG_9P_FS_POSIX_ACL is not set
# CONFIG_9P_FS_SECURITY is not set
CONFIG_NLS=y


