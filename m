Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E095E760CBB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 10:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbjGYIOK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 04:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbjGYIOB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:14:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C31E57
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 01:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690272794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NVFlpvoBG2Pd8ROblvK7dT35aA2f9UXwu06vV3Or/NA=;
        b=TmBeqxFl+4N8r3XBS2CWC6y086SEF7qWhSZ4ZYlZEF78m7A26xes+xjNHqs/+IfBX6CrNX
        Nga17whqRkov1qtG8OVYQNO0T9RVgJOptjKdPVv/yj05ncR3LdkNWejb5qJVt2G8CRVAEl
        IdH2jdeTN25L0cuLEYLvORM1EQOKvOU=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-1MuL57XqMMS5kw8wH9jWtA-1; Tue, 25 Jul 2023 04:13:12 -0400
X-MC-Unique: 1MuL57XqMMS5kw8wH9jWtA-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1bba5563cd6so8731375ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 01:13:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690272791; x=1690877591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVFlpvoBG2Pd8ROblvK7dT35aA2f9UXwu06vV3Or/NA=;
        b=Ln5P+5wo0/J1X4CNcmeT392wovL/rVROL+A1zsvs2ZrM4Dd3y6dU49ObcvEKfdmk78
         ROxxAaG8K2LoXsKyFsyTOlvZimE+USMXg493jwUVLJsmH/rkfbCQhAYRNX0Rs9xa3Myi
         jZJRcCHQGyhIRK5E1lIa7qXTPT/k8JFMtc+HKKtHtRn3MDvL6izhZpwFN7qCKl2odspn
         Qa4n1hNl0RyxAA6zVWl2cz5AELaq4nklU9qGHYAOQsMcMTchdXyuKrnPgtW4WXj220wE
         JimDPkxuVPqLIuCtaYzDsx1O64shXVTfZ//DbSq+bKYHcRzcRy8NYbl7W7YewkJkTyQF
         0fyA==
X-Gm-Message-State: ABy/qLYY0uzbbVji9E3A8uMgU2TmT2vuVHeZsZH6+5HuHsJt/EYuVfNj
        xhOE296BLTe4fkTzzyI5Ev5O4n8yWl6qhVzBrdcDXtaWfj6j+/r97Tr/y07SJFnOc69ecSEkNT4
        vt0tBQyK9aJEj6W+vbp9O2KTN3EtsX3iz+tLABeI=
X-Received: by 2002:a17:902:f548:b0:1b9:cac2:362c with SMTP id h8-20020a170902f54800b001b9cac2362cmr12058436plf.4.1690272791180;
        Tue, 25 Jul 2023 01:13:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEq1fexnKTyNCUR/yxdcgQOvSDPp01kvwpLQVONYeZSgHJc/XafdI7Sh+/hed7HrS5zH9QEpg==
X-Received: by 2002:a17:902:f548:b0:1b9:cac2:362c with SMTP id h8-20020a170902f54800b001b9cac2362cmr12058424plf.4.1690272790838;
        Tue, 25 Jul 2023 01:13:10 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902bcca00b001b850c9af71sm10285837pls.285.2023.07.25.01.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 01:13:10 -0700 (PDT)
Date:   Tue, 25 Jul 2023 16:13:07 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH] fstests: add helper to canonicalize devices used to
 enable persistent disks
Message-ID: <20230725081307.xydlwjdl4lq3ts3m@zlang-mailbox>
References: <20230720061727.2363548-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720061727.2363548-1-mcgrof@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 19, 2023 at 11:17:27PM -0700, Luis Chamberlain wrote:
> The filesystem configuration file does not allow you to use symlinks to
> devices given the existing sanity checks verify that the target end
> device matches the source.
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
> support to use real NVMe drives. The drives it uses for the filesystem
> configuration optionally is with NVMe eui symlinks so to allow
> the same drives to be used over reboots.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---

Hi Luis,

Hmmm... this's a default behavior change for fstests, although I'm not sure
what will be affect. I'm wondering if we should do this in fstests. I don't
want to tell the users that the device names they give to fstests will always
be truned to real names from now on.

Generally the users of fstests provide the device names, so the users
might need to take care of the name is "/dev/mapper/testvg-testdev"
or "/dev/dm-4". The users can deal with the device names when their
script prepare to run fstests.

If more developers prefer this change, I'd like to make it to be
optional by an option of ./check at least, not always turn devname
to realpath. Welcome review points from others.

>  check         |  1 +
>  common/config | 44 +++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/check b/check
> index 89e7e7bf20df..d063d3f498fd 100755
> --- a/check
> +++ b/check
> @@ -734,6 +734,7 @@ function run_section()
>  	fi
>  
>  	get_next_config $section
> +	_canonicalize_devices
>  
>  	mkdir -p $RESULT_BASE
>  	if [ ! -d $RESULT_BASE ]; then
> diff --git a/common/config b/common/config
> index 936ac225f4b1..f5a3815a0435 100644
> --- a/common/config
> +++ b/common/config
> @@ -655,6 +655,47 @@ _canonicalize_mountpoint()
>  	echo "$parent/$base"
>  }
>  
> +# Enables usage of /dev/disk/by-id/ symlinks to persist target devices
> +# over reboots
> +_canonicalize_devices()
> +{
> +	if [ ! -z "$TEST_DEV" ] && [ -L $TEST_DEV ]; then

I think [ -L "$TEST_DEV" ] is enough.

> +		TEST_DEV=$(realpath -e $TEST_DEV)

Anyone knows the difference of realpatch and readlink?

> +	fi
> +
> +	if [ ! -z "$SCRATCH_DEV" ] && [ -L $SCRATCH_DEV ]; then
> +		SCRATCH_DEV=$(realpath -e $SCRATCH_DEV)
> +	fi
> +
> +	if [ ! -z "$TEST_LOGDEV" ] && [ -L $TEST_LOGDEV ]; then
> +		TEST_LOGDEV=$(realpath -e $TEST_LOGDEV)
> +	fi
> +
> +	if [ ! -z "$TEST_RTDEV" ] && [ -L $TEST_RTDEV ]; then
> +		TEST_RTDEV=$(realpath -e $TEST_RTDEV)
> +	fi
> +
> +	if [ ! -z "$SCRATCH_RTDEV" ] && [ -L $SCRATCH_RTDEV ]; then
> +		SCRATCH_RTDEV=$(realpath -e $SCRATCH_RTDEV)
> +	fi
> +
> +	if [ ! -z "$LOGWRITES_DEV" ] && [ -L $LOGWRITES_DEV ]; then
> +		LOGWRITES_DEV=$(realpath -e $LOGWRITES_DEV)
> +	fi
> +
> +	if [ ! -z "$SCRATCH_DEV_POOL" ]; then
> +		NEW_SCRATCH_POOL=""
> +		for i in $SCRATCH_DEV_POOL; do
> +			if [ -L $i ]; then
> +				NEW_SCRATCH_POOL="$NEW_SCRATCH_POOL $(realpath -e $i)"
> +			else
> +				NEW_SCRATCH_POOL="$NEW_SCRATCH_POOL $i)"
                                                                     ^^^

What's this half ")" for ?


Thanks,
Zorro


> +			fi
> +		done
> +		SCRATCH_DEV_POOL="$NEW_SCRATCH_POOL"
> +	fi
> +}
> +
>  # On check -overlay, for the non multi section config case, this
>  # function is called on every test, before init_rc().
>  # When SCRATCH/TEST_* vars are defined in config file, config file
> @@ -785,7 +826,6 @@ get_next_config() {
>  	fi
>  
>  	parse_config_section $1
> -
>  	if [ ! -z "$OLD_FSTYP" ] && [ $OLD_FSTYP != $FSTYP ]; then
>  		[ -z "$MOUNT_OPTIONS" ] && _mount_opts
>  		[ -z "$TEST_FS_MOUNT_OPTS" ] && _test_mount_opts
> @@ -901,5 +941,7 @@ else
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

