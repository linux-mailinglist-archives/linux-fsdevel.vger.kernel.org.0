Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56F076DF49
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 06:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjHCEHD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Aug 2023 00:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbjHCEG7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Aug 2023 00:06:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86972D72
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 21:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691035574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/JX7cAs7chLrarjH6MrLPnJz44xJdfnup4JJenCs9Y8=;
        b=airg41NvBiwn+zgM1V6vpRXb+vML2F8neZt7+K4JZQXhzqq22Z1whqsfHXarvwp/IPTasx
        tJkOHANvB2g/zeg+DHgFq/DsrWIMYlEgVUnMWZnjwN1CtyM2YcjadqHxeoDEi25Mp3fMYf
        jTcdHKcUzpppdcuaBveA3tD89ND82Qg=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-sZ4O9R9JPaiL1_b3sIlLZA-1; Thu, 03 Aug 2023 00:06:13 -0400
X-MC-Unique: sZ4O9R9JPaiL1_b3sIlLZA-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6bb0ba9fc81so892487a34.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Aug 2023 21:06:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691035572; x=1691640372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JX7cAs7chLrarjH6MrLPnJz44xJdfnup4JJenCs9Y8=;
        b=VSd6eVpRyIkGJls3p4nNm7KKlDtH1ZZ5aLd7DjF3KZpKcyO5LHVuhHOchKXQJ9vIaa
         x0r22GWeOMVFZWnHax0NJeX1p2V8aRH3AUkFv/rnfOauyI5beQgPhJ3EYkv7Oy8DhCXe
         nBClFDDK368obZv2iqSm8Tjok/WR8kovKnRjIOjN3TaIlLHbhL/bHe+ERUcWQytYVzB4
         5EWOkOQHkLqO3HBB9exHoicbYwBbXDteJuCQ6BZon5NDpt2G/j+wgrkC+VIWF+9Pjt2g
         RFCQl0uTE6ppuvoLYwjZs4pc1wBJEee3d6CwlIpkAL5uoj9eOOYuPu5Zv2w7jYdbZrvo
         UINA==
X-Gm-Message-State: ABy/qLaCjg3awnvwScQBgxyRd87gTCyUDaNbJLgOwIP/J9ofTOWfcCQi
        93g44qtb93zLnhmcGUi2oTf+z/HDBdraB/cw8VLNPnJLqTJVkX0LUEpvRkzhj6vCtb0veOJvzHh
        9ZlO9jQiaNqz8DJa+jU2UGj2hYw==
X-Received: by 2002:a05:6830:1016:b0:6b9:9129:dddf with SMTP id a22-20020a056830101600b006b99129dddfmr20079924otp.16.1691035572643;
        Wed, 02 Aug 2023 21:06:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGDciwVs7e8bxeFPbFtGT6SCsgLYajkMm4G923j7g9rMQqPkn0wzXiSF+kTBoSNoNxO0vl30g==
X-Received: by 2002:a05:6830:1016:b0:6b9:9129:dddf with SMTP id a22-20020a056830101600b006b99129dddfmr20079905otp.16.1691035572268;
        Wed, 02 Aug 2023 21:06:12 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id e12-20020a63744c000000b005641fadb844sm10049195pgn.49.2023.08.02.21.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 21:06:11 -0700 (PDT)
Date:   Thu, 3 Aug 2023 12:06:07 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     fstests@vger.kernel.org, aalbersh@redhat.com,
        chandan.babu@oracle.com, amir73il@gmail.com, josef@toxicpanda.com,
        djwong@kernel.org, linux-fsdevel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v2] fstests: add helper to canonicalize devices used to
 enable persistent disks
Message-ID: <20230803040607.eytde4s5dnqavtqb@zlang-mailbox>
References: <20230802191535.1365096-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802191535.1365096-1-mcgrof@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 02, 2023 at 12:15:35PM -0700, Luis Chamberlain wrote:
> The filesystem configuration file does not allow you to use symlinks to
> real devices given the existing sanity checks verify that the target end
> device matches the source. Device mapper links work but not symlinks for
> real drives do not.
> 
> Using a symlink is desirable if you want to enable persistent tests
> across reboots. For example you may want to use /dev/disk/by-id/nvme-eui.*
> so to ensure that the same drives are used even after reboot. This
> is very useful if you are testing for example with a virtualized
> environment and are using PCIe passthrough with other qemu NVMe drives
> with one or many NVMe drives.
> 
> To enable support just add a helper to canonicalize devices prior to
> running the tests.
> 
> This allows one test runner, kdevops, which I just extended with
> support to use real NVMe drives it has support now to use nvme EUI
> symlinks and fallbacks to nvme model + serial symlinks as not all
> NVMe drives support EUIs. The drives it uses for the filesystem
> configuration optionally is with NVMe eui symlinks so to allow
> the same drives to be used over reboots.
> 
> For instance this works today with real nvme drives:
> 
> mkfs.xfs -f /dev/nvme0n1
> mount /dev/nvme0n1 /mnt
> TEST_DIR=/mnt TEST_DEV=/dev/nvme0n1 FSTYP=xfs ./check generic/110
> 
> FSTYP         -- xfs (debug)
> PLATFORM      -- Linux/x86_64 flax-mtr01 6.5.0-rc3-djwx #rc3 SMP PREEMPT_DYNAMIC Wed Jul 26 14:26:48 PDT 2023
> 
> generic/110        2s
> Ran: generic/110
> Passed all 1 tests
> 
> But this does not:
> 
> TEST_DIR=/mnt TEST_DEV=/dev/disk/by-id/nvme-eui.0035385411904c1e FSTYP=xfs ./check generic/110
> mount: /mnt: /dev/disk/by-id/nvme-eui.0035385411904c1e already mounted on /mnt.
> common/rc: retrying test device mount with external set
> mount: /mnt: /dev/disk/by-id/nvme-eui.0035385411904c1e already mounted on /mnt.
> common/rc: could not mount /dev/disk/by-id/nvme-eui.0035385411904c1e on /mnt
> 
> umount /mnt
> TEST_DIR=/mnt TEST_DEV=/dev/disk/by-id/nvme-eui.0035385411904c1e FSTYP=xfs ./check generic/110
> TEST_DEV=/dev/disk/by-id/nvme-eui.0035385411904c1e is mounted but not on TEST_DIR=/mnt - aborting
> Already mounted result:
> /dev/disk/by-id/nvme-eui.0035385411904c1e /mnt
> 
> This fixes this. This allows the same real drives for a test to be
> used over and over after reboots.
> 
> Use readlink -e because that support exists since 2004:
> 
> https://github.com/coreutils/coreutils/commit/e0b8973bd4b146b5fb39641a4ee7984e922c3ff5
> 
> realpath is much newer than readlink, it's first commit including
> support for -e dates back to 2011:
> 
> https://github.com/coreutils/coreutils/commit/77ea441f79aa115f79b47d9c1fc9c0004c5c7111
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
> 
> Changes on v2:
> 
>  - Enhanced the commit log to describe the existing status quo where
>    at least device mapper symlinks work but not for real drives. Also
>    provide an example output of the issue and use case as implied by
>    Darrick.
>  - Added CANON_DEVS to disable this by default, document it
>  - simplify _canonicalize_devices() with as many one liners as possible
>  - use readlink -e because my history scavanging has found it has existed for
>    7 years longer thjan realpath -e support. Documen this on the commit
>    log as well.
> 
>  README        |  3 +++
>  check         |  1 +
>  common/config | 32 +++++++++++++++++++++++++++++++-
>  3 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/README b/README
> index 1ca506492bf0..97ef63d6d693 100644
> --- a/README
> +++ b/README
> @@ -268,6 +268,9 @@ Misc:
>     this option is supported for all filesystems currently only -overlay is
>     expected to run without issues. For other filesystems additional patches
>     and fixes to the test suite might be needed.
> + - set CANON_DEVS=yes to canonicalize device symlinks. This will let you
> +   for example use something like TEST_DEV/dev/disk/by-id/nvme-* so the
> +   device remains persistent between reboots. This is disabled by default.
>  
>  ______________________
>  USING THE FSQA SUITE
> diff --git a/check b/check
> index 0bf5b22e061a..577e09655844 100755
> --- a/check
> +++ b/check
> @@ -711,6 +711,7 @@ function run_section()
>  	fi
>  
>  	get_next_config $section
> +	_canonicalize_devices
>  
>  	mkdir -p $RESULT_BASE
>  	if [ ! -d $RESULT_BASE ]; then
> diff --git a/common/config b/common/config
> index 6c8cb3a5ba68..7d74c285ac71 100644
> --- a/common/config
> +++ b/common/config
> @@ -25,6 +25,9 @@
>  # KEEP_DMESG -      whether to keep all dmesg for each test case.
>  #                   yes: keep all dmesg
>  #                   no: only keep dmesg with error/warning (default)
> +# CANON_DEVS -      whether or not to canonicalize device symlinks
> +#                   yes: canonicalize device symlinks
> +#                   no (default) do not canonicalize device if they are symlinks
>  #
>  # - These can be added to $HOST_CONFIG_DIR (witch default to ./config)
>  #   below or a separate local configuration file can be used (using
> @@ -644,6 +647,32 @@ _canonicalize_mountpoint()
>  	echo "$parent/$base"
>  }
>  
> +# Enables usage of /dev/disk/by-id/ symlinks to persist target devices
> +# over reboots
> +_canonicalize_devices()
> +{
> +	if [ "$CANON_DEVS" != "yes" ]; then
> +		return
> +	fi
> +	[ -L "$TEST_DEV" ]	&& TEST_DEV=$(readlink -e "$TEST_DEV")
> +	[ -L $SCRATCH_DEV ]	&& SCRATCH_DEV=$(readlink -e "$SCRATCH_DEV")

With or without "" will be different...

> +	[ -L $TEST_LOGDEV ]	&& TEST_LOGDEV=$(readlink -e "$TEST_LOGDEV")
> +	[ -L $TEST_RTDEV ]	&& TEST_RTDEV=$(readlink -e "$TEST_RTDEV")
> +	[ -L $SCRATCH_RTDEV ]	&& SCRATCH_RTDEV=$(readlink -e "$SCRATCH_RTDEV")
> +	[ -L $LOGWRITES_DEV ]	&& LOGWRITES_DEV=$(readlink -e "$LOGWRITES_DEV")

You've give "" to $TEST_DEV, others should be same.

> +	if [ ! -z "$SCRATCH_DEV_POOL" ]; then
> +		NEW_SCRATCH_POOL=""

If the NEW_SCRATCH_POOL isn't used in other places, it can be a local variable as
a tmp variable.

Thanks,
Zorro

> +		for i in $SCRATCH_DEV_POOL; do
> +			if [ -L $i ]; then
> +				NEW_SCRATCH_POOL="$NEW_SCRATCH_POOL $(readlink -e $i)"
> +			else
> +				NEW_SCRATCH_POOL="$NEW_SCRATCH_POOL $i)"
> +			fi
> +		done
> +		SCRATCH_DEV_POOL="$NEW_SCRATCH_POOL"
> +	fi
> +}
> +
>  # On check -overlay, for the non multi section config case, this
>  # function is called on every test, before init_rc().
>  # When SCRATCH/TEST_* vars are defined in config file, config file
> @@ -774,7 +803,6 @@ get_next_config() {
>  	fi
>  
>  	parse_config_section $1
> -
>  	if [ ! -z "$OLD_FSTYP" ] && [ $OLD_FSTYP != $FSTYP ]; then
>  		[ -z "$MOUNT_OPTIONS" ] && _mount_opts
>  		[ -z "$TEST_FS_MOUNT_OPTS" ] && _test_mount_opts
> @@ -890,5 +918,7 @@ else
>  	fi
>  fi
>  
> +_canonicalize_devices
> +
>  # make sure this script returns success
>  /bin/true
> -- 
> 2.39.2
> 

