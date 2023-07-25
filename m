Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE8D761DBA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 17:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbjGYPyq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 11:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbjGYPyp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:54:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B79211C;
        Tue, 25 Jul 2023 08:54:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E77B1617B4;
        Tue, 25 Jul 2023 15:54:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BDCAC433C8;
        Tue, 25 Jul 2023 15:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690300480;
        bh=Tz60Ac0FER1CvTprz/6D26g4/Q0yzf0YB0v1K+OBh60=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WeOhF5c6isuxxtBsASpJPFQcjkCIppflXFFX/hq8ddOj3/xYd+LuWZ57o8a5H0qOS
         jmCH1VKiyEE34V7fClbvv425gb/ve4u9tzNMERuutZ/by0YfUceZKF6VSNs/vD9v0Y
         NH6S8CO00AUt5wwb7pGI+BnLkoHek+tp0MrmERt0qGlwJx2nrlLXMXzOx41f77SWGB
         T6jwLLSBaaoR4J6oI0wVQJYgVCt0rX66+ZIvyfmPg2aWUGixdXrk6/gwoHP3YzvxcX
         CXkCS1u8jefdbPomf4qWQAsu13eztVeEQjB6n9a5IW1OidxybeDHPrVOZc22aaPRS/
         ivUfCkZaGhY8w==
Date:   Tue, 25 Jul 2023 08:54:39 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zorro Lang <zlang@redhat.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, fstests@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] fstests: add helper to canonicalize devices used to
 enable persistent disks
Message-ID: <20230725155439.GF11340@frogsfrogsfrogs>
References: <20230720061727.2363548-1-mcgrof@kernel.org>
 <20230725081307.xydlwjdl4lq3ts3m@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725081307.xydlwjdl4lq3ts3m@zlang-mailbox>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 25, 2023 at 04:13:07PM +0800, Zorro Lang wrote:
> On Wed, Jul 19, 2023 at 11:17:27PM -0700, Luis Chamberlain wrote:
> > The filesystem configuration file does not allow you to use symlinks to
> > devices given the existing sanity checks verify that the target end
> > device matches the source.
> > 
> > Using a symlink is desirable if you want to enable persistent tests
> > across reboots. For example you may want to use /dev/disk/by-id/nvme-eui.*
> > so to ensure that the same drives are used even after reboot. This
> > is very useful if you are testing for example with a virtualized
> > environment and are using PCIe passthrough with other qemu NVMe drives
> > with one or many NVMe drives.
> > 
> > To enable support just add a helper to canonicalize devices prior to
> > running the tests.
> > 
> > This allows one test runner, kdevops, which I just extended with
> > support to use real NVMe drives. The drives it uses for the filesystem
> > configuration optionally is with NVMe eui symlinks so to allow
> > the same drives to be used over reboots.
> > 
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > ---
> 
> Hi Luis,
> 
> Hmmm... this's a default behavior change for fstests, although I'm not sure
> what will be affect. I'm wondering if we should do this in fstests. I don't
> want to tell the users that the device names they give to fstests will always
> be truned to real names from now on.
> 
> Generally the users of fstests provide the device names, so the users
> might need to take care of the name is "/dev/mapper/testvg-testdev"
> or "/dev/dm-4". The users can deal with the device names when their
> script prepare to run fstests.
> 
> If more developers prefer this change, I'd like to make it to be
> optional by an option of ./check at least, not always turn devname
> to realpath. Welcome review points from others.

Hmm.  SCRATCH_DEV=/dev/testvg/testlv works right now, it'd be sort of
annoying to have "/dev/dm-4" get written into the report and then you've
lost the correlation to whatever the user passed in.

Oh wait.  My giant mound of ./check wrapper script already does that
canonicalization and has for years.

Ok.  Sounds good to me then. :P

> >  check         |  1 +
> >  common/config | 44 +++++++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 44 insertions(+), 1 deletion(-)
> > 
> > diff --git a/check b/check
> > index 89e7e7bf20df..d063d3f498fd 100755
> > --- a/check
> > +++ b/check
> > @@ -734,6 +734,7 @@ function run_section()
> >  	fi
> >  
> >  	get_next_config $section
> > +	_canonicalize_devices
> >  
> >  	mkdir -p $RESULT_BASE
> >  	if [ ! -d $RESULT_BASE ]; then
> > diff --git a/common/config b/common/config
> > index 936ac225f4b1..f5a3815a0435 100644
> > --- a/common/config
> > +++ b/common/config
> > @@ -655,6 +655,47 @@ _canonicalize_mountpoint()
> >  	echo "$parent/$base"
> >  }
> >  
> > +# Enables usage of /dev/disk/by-id/ symlinks to persist target devices
> > +# over reboots
> > +_canonicalize_devices()
> > +{
> > +	if [ ! -z "$TEST_DEV" ] && [ -L $TEST_DEV ]; then
> 
> I think [ -L "$TEST_DEV" ] is enough.

I don't think it is.

$ unset moo
$ [ -L $moo ]
$ echo $?
0
$ realpath -e $moo
realpath: missing operand
Try 'realpath --help' for more information.

> > +		TEST_DEV=$(realpath -e $TEST_DEV)
> 
> Anyone knows the difference of realpatch and readlink?

readlink doesn't follow nested symlinks; realpath does:

$ touch /tmp/a
$ ln -s /tmp/a /tmp/b
$ ln -s /tmp/b /tmp/c
$ readlink /tmp/c
/tmp/b
$ realpath /tmp/c
/tmp/a
$ readlink -m /tmp/c
/tmp/a

> > +	fi
> > +
> > +	if [ ! -z "$SCRATCH_DEV" ] && [ -L $SCRATCH_DEV ]; then
> > +		SCRATCH_DEV=$(realpath -e $SCRATCH_DEV)

Extra question: Shouldn't we be putting theis ^^^ variables in quotes?

Supposing someone starts passing in
SCRATCH_DEV=/dev/disk/by-label/har har"

This expression will barf everywhere:

$ SCRATCH_DEV=$(realpath -e $SCRATCH_DEV)
realpath: /dev/disk/by-label/har: No such file or directory
realpath: har: No such file or directory

Due to the lack of quoting on its way to turning that into /dev/sda3.
Granted fstests has historically required no spaces in anything, but
still, it's bad hygiene.

[writing anything in bash is bad hygiene, but for the sweet sweet pipe
goodness]

> > +	fi
> > +
> > +	if [ ! -z "$TEST_LOGDEV" ] && [ -L $TEST_LOGDEV ]; then
> > +		TEST_LOGDEV=$(realpath -e $TEST_LOGDEV)
> > +	fi
> > +
> > +	if [ ! -z "$TEST_RTDEV" ] && [ -L $TEST_RTDEV ]; then
> > +		TEST_RTDEV=$(realpath -e $TEST_RTDEV)
> > +	fi
> > +
> > +	if [ ! -z "$SCRATCH_RTDEV" ] && [ -L $SCRATCH_RTDEV ]; then
> > +		SCRATCH_RTDEV=$(realpath -e $SCRATCH_RTDEV)
> > +	fi
> > +
> > +	if [ ! -z "$LOGWRITES_DEV" ] && [ -L $LOGWRITES_DEV ]; then
> > +		LOGWRITES_DEV=$(realpath -e $LOGWRITES_DEV)
> > +	fi
> > +
> > +	if [ ! -z "$SCRATCH_DEV_POOL" ]; then
> > +		NEW_SCRATCH_POOL=""
> > +		for i in $SCRATCH_DEV_POOL; do
> > +			if [ -L $i ]; then
> > +				NEW_SCRATCH_POOL="$NEW_SCRATCH_POOL $(realpath -e $i)"
> > +			else
> > +				NEW_SCRATCH_POOL="$NEW_SCRATCH_POOL $i)"
>                                                                      ^^^
> 
> What's this half ")" for ?

Some kind of typo, I assume...

--D

> 
> Thanks,
> Zorro
> 
> 
> > +			fi
> > +		done
> > +		SCRATCH_DEV_POOL="$NEW_SCRATCH_POOL"
> > +	fi
> > +}
> > +
> >  # On check -overlay, for the non multi section config case, this
> >  # function is called on every test, before init_rc().
> >  # When SCRATCH/TEST_* vars are defined in config file, config file
> > @@ -785,7 +826,6 @@ get_next_config() {
> >  	fi
> >  
> >  	parse_config_section $1
> > -
> >  	if [ ! -z "$OLD_FSTYP" ] && [ $OLD_FSTYP != $FSTYP ]; then
> >  		[ -z "$MOUNT_OPTIONS" ] && _mount_opts
> >  		[ -z "$TEST_FS_MOUNT_OPTS" ] && _test_mount_opts
> > @@ -901,5 +941,7 @@ else
> >  	fi
> >  fi
> >  
> > +_canonicalize_devices
> > +
> >  # make sure this script returns success
> >  /bin/true
> > -- 
> > 2.39.2
> > 
> 
