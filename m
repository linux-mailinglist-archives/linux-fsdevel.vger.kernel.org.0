Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD000763DC0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 19:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbjGZRfD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 13:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjGZRex (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 13:34:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B8C2695;
        Wed, 26 Jul 2023 10:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=66wsCMpQU6FfBWm9l+EX673LWPMXJ2OOrUUr0K2e7g4=; b=SAiGzH+YNs/4c7c+fVGjD6Wi5b
        66j65ZBDLnqU1rftVrAWXNxbSRQraEKMUHLdgCG/vvBinzOTK107lGJaY1pCJ0DD50CugUoOqlYAI
        wE8669Fy28G/JulDPzzMyFzuvoLK4IW7P3WfaTMrZpMne0GDalRfVcGIkhdLccm5i9DKj9cpaDcsT
        elqxek1ngORwtQpyNnlVyWVdsZmnB4RS2KkLPbtxd0wo+MsqdgKq5US3bOq6N48+/fCS8o6GF603v
        npaDAdsWqmz9PSBYTHYOoYGIp4A/9IfUNgilLuHAd+UBg6/qtLnUBYyCDa3yi2XTSxW2MenGNFgGx
        zPRbDAkg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qOiPS-00BAtc-0C;
        Wed, 26 Jul 2023 17:34:50 +0000
Date:   Wed, 26 Jul 2023 10:34:50 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Zorro Lang <zlang@redhat.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] fstests: add helper to canonicalize devices used to
 enable persistent disks
Message-ID: <ZMFZOi3zJ8sevlb5@bombadil.infradead.org>
References: <20230720061727.2363548-1-mcgrof@kernel.org>
 <20230725081307.xydlwjdl4lq3ts3m@zlang-mailbox>
 <20230725155439.GF11340@frogsfrogsfrogs>
 <20230725175009.jv4hbqxtags6qh5r@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725175009.jv4hbqxtags6qh5r@zlang-mailbox>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 26, 2023 at 01:50:09AM +0800, Zorro Lang wrote:
> On Tue, Jul 25, 2023 at 08:54:39AM -0700, Darrick J. Wong wrote:
> > On Tue, Jul 25, 2023 at 04:13:07PM +0800, Zorro Lang wrote:
> > > On Wed, Jul 19, 2023 at 11:17:27PM -0700, Luis Chamberlain wrote:
> > > > Using a symlink is desirable if you want to enable persistent tests
> > > > across reboots. For example you may want to use /dev/disk/by-id/nvme-eui.*
> > > > so to ensure that the same drives are used even after reboot.
> > >
> > > If more developers prefer this change, I'd like to make it to be
> > > optional by an option of ./check at least, not always turn devname
> > > to realpath. Welcome review points from others.
> > 
> > Hmm.  SCRATCH_DEV=/dev/testvg/testlv works right now, it'd be sort of
> > annoying to have "/dev/dm-4" get written into the report and then you've
> > lost the correlation to whatever the user passed in.
> > 
> > Oh wait.  My giant mound of ./check wrapper script already does that
> > canonicalization and has for years.
> > 
> > Ok.  Sounds good to me then. :P
> 
> So you hope fstests can do this translation (use real device name) by default?

I'm fine if we make this optional too. In my next spin I'll add an
option that does this.

> > > I think [ -L "$TEST_DEV" ] is enough.
> > 
> > I don't think it is.
> > 
> > $ unset moo
> > $ [ -L $moo ]
> 
> The double quotation marks "" are needed.

Indeed it does. Will go with that for v2.

> > $ echo $?
> > 0
> > $ realpath -e $moo
> > realpath: missing operand
> > Try 'realpath --help' for more information.
> > 
> > > > +		TEST_DEV=$(realpath -e $TEST_DEV)
> > > 
> > > Anyone knows the difference of realpatch and readlink?
> > 
> > readlink doesn't follow nested symlinks; realpath does:
> > 
> > $ touch /tmp/a
> > $ ln -s /tmp/a /tmp/b
> > $ ln -s /tmp/b /tmp/c
> > $ readlink /tmp/c
> > /tmp/b
> > $ realpath /tmp/c
> > /tmp/a
> > $ readlink -m /tmp/c
> > /tmp/a
> 
> The -e option helps:
> 
> # readlink -e /tmp/c
> /tmp/a

I can trace readlink -e support back to 2004:

https://github.com/coreutils/coreutils/commit/e0b8973bd4b146b5fb39641a4ee7984e922c3ff5

> # realpath -e /tmp/c
> /tmp/a

realpeath is much newer than readlink, it's first commit including
support for -e dates back to 2011;

https://github.com/coreutils/coreutils/commit/77ea441f79aa115f79b47d9c1fc9c0004c5c7111

And so canonicalizing with readlink is 7 years older and likely to be
supported in more ancient distros with older coreutils. I'll go with
readlink -e unless I hear otherwise.

> > > > +	fi
> > > > +
> > > > +	if [ ! -z "$SCRATCH_DEV" ] && [ -L $SCRATCH_DEV ]; then
> > > > +		SCRATCH_DEV=$(realpath -e $SCRATCH_DEV)
> > 
> > Extra question: Shouldn't we be putting theis ^^^ variables in quotes?
> 
> Make sense to me.

Done. The only eye sore is how to convert the loop for the SCRATCH_DEV_POOL,
here's what I have for a v2:

diff --git a/README b/README
index 1ca506492bf0..97ef63d6d693 100644
--- a/README
+++ b/README
@@ -268,6 +268,9 @@ Misc:
    this option is supported for all filesystems currently only -overlay is
    expected to run without issues. For other filesystems additional patches
    and fixes to the test suite might be needed.
+ - set CANON_DEVS=yes to canonicalize device symlinks. This will let you
+   for example use something like TEST_DEV/dev/disk/by-id/nvme-* so the
+   device remains persistent between reboots. This is disabled by default.
 
 ______________________
 USING THE FSQA SUITE
diff --git a/check b/check
index 0bf5b22e061a..577e09655844 100755
--- a/check
+++ b/check
@@ -711,6 +711,7 @@ function run_section()
 	fi
 
 	get_next_config $section
+	_canonicalize_devices
 
 	mkdir -p $RESULT_BASE
 	if [ ! -d $RESULT_BASE ]; then
diff --git a/common/config b/common/config
index 6c8cb3a5ba68..7d74c285ac71 100644
--- a/common/config
+++ b/common/config
@@ -25,6 +25,9 @@
 # KEEP_DMESG -      whether to keep all dmesg for each test case.
 #                   yes: keep all dmesg
 #                   no: only keep dmesg with error/warning (default)
+# CANON_DEVS -      whether or not to canonicalize device symlinks
+#                   yes: canonicalize device symlinks
+#                   no (default) do not canonicalize device if they are symlinks
 #
 # - These can be added to $HOST_CONFIG_DIR (witch default to ./config)
 #   below or a separate local configuration file can be used (using
@@ -644,6 +647,32 @@ _canonicalize_mountpoint()
 	echo "$parent/$base"
 }
 
+# Enables usage of /dev/disk/by-id/ symlinks to persist target devices
+# over reboots
+_canonicalize_devices()
+{
+	if [ "$CANON_DEVS" != "yes" ]; then
+		return
+	fi
+	[ -L "$TEST_DEV" ]	&& TEST_DEV=$(readlink -e "$TEST_DEV")
+	[ -L $SCRATCH_DEV ]	&& SCRATCH_DEV=$(readlink -e "$SCRATCH_DEV")
+	[ -L $TEST_LOGDEV ]	&& TEST_LOGDEV=$(readlink -e "$TEST_LOGDEV")
+	[ -L $TEST_RTDEV ]	&& TEST_RTDEV=$(readlink -e "$TEST_RTDEV")
+	[ -L $SCRATCH_RTDEV ]	&& SCRATCH_RTDEV=$(readlink -e "$SCRATCH_RTDEV")
+	[ -L $LOGWRITES_DEV ]	&& LOGWRITES_DEV=$(readlink -e "$LOGWRITES_DEV")
+	if [ ! -z "$SCRATCH_DEV_POOL" ]; then
+		NEW_SCRATCH_POOL=""
+		for i in $SCRATCH_DEV_POOL; do
+			if [ -L $i ]; then
+				NEW_SCRATCH_POOL="$NEW_SCRATCH_POOL $(readlink -e $i)"
+			else
+				NEW_SCRATCH_POOL="$NEW_SCRATCH_POOL $i)"
+			fi
+		done
+		SCRATCH_DEV_POOL="$NEW_SCRATCH_POOL"
+	fi
+}
+
 # On check -overlay, for the non multi section config case, this
 # function is called on every test, before init_rc().
 # When SCRATCH/TEST_* vars are defined in config file, config file
@@ -774,7 +803,6 @@ get_next_config() {
 	fi
 
 	parse_config_section $1
-
 	if [ ! -z "$OLD_FSTYP" ] && [ $OLD_FSTYP != $FSTYP ]; then
 		[ -z "$MOUNT_OPTIONS" ] && _mount_opts
 		[ -z "$TEST_FS_MOUNT_OPTS" ] && _test_mount_opts
@@ -890,5 +918,7 @@ else
 	fi
 fi
 
+_canonicalize_devices
+
 # make sure this script returns success
 /bin/true
