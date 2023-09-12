Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84DE79D6D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 18:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237099AbjILQwq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Sep 2023 12:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237112AbjILQwo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:52:44 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86951704
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Sep 2023 09:52:38 -0700 (PDT)
Received: from [127.0.0.1] ([98.35.210.218])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 38CGqIRk2334556
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 12 Sep 2023 09:52:19 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 38CGqIRk2334556
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023081101; t=1694537542;
        bh=0KH8w8NSbCUzAiFHSpcTVc4YhQqwvAP1rl7hUaut9UY=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=UAaHz6cGaDRTC59RuycI6eVd+HmtUoIxY5aoqNDPx8mjwRz0TamKFR52WHxqjFQuJ
         uiHMR23ZVr/ZjPDZJQfwufDUOrKuIJCVuxbOJEDrs2BLVlMtVnoSargRFn4OCXBavQ
         fHCdUBylACQ4izMxnZwnuqdy0gOlYRiRu10jII0Scc++Er7yKK4K4ogMg5/cOCaHFs
         YKorvBzw6Xl7upe30VkOnh4IzD9ZrmHPTPATJgsyi060GEa7TWt9YOQw+u03ix2vgA
         fCPYcJcXb9bqo+T4tHGqaCAOoFek1tHBIERRnKWTFROSDUXbC9QlcCWXs3eA0JU0mH
         MrfhWwzW1cCiw==
Date:   Tue, 12 Sep 2023 09:52:17 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
User-Agent: K-9 Mail for Android
In-Reply-To: <20230911031015.GF701295@mit.edu>
References: <ZO9NK0FchtYjOuIH@infradead.org> <ZPe0bSW10Gj7rvAW@dread.disaster.area> <ZPe4aqbEuQ7xxJnj@casper.infradead.org> <8dd2f626f16b0fc863d6a71561196950da7e893f.camel@HansenPartnership.com> <ZPyS4J55gV8DBn8x@casper.infradead.org> <a21038464ad0afd5dfb88355e1c244152db9b8da.camel@HansenPartnership.com> <20230911031015.GF701295@mit.edu>
Message-ID: <A77D5966-B593-4D0F-9704-1EB0AAEF1FD1@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On September 10, 2023 8:10:15 PM PDT, Theodore Ts'o <tytso@mit=2Eedu> wrote=
:
>On Sun, Sep 10, 2023 at 03:51:42PM -0400, James Bottomley wrote:
>> On Sat, 2023-09-09 at 16:44 +0100, Matthew Wilcox wrote:
>> > There hasn't been an HFS maintainer since 2011, and it wasn't a
>> > problem until syzbot decreed that every filesystem bug is a security
>> > bug=2E=C2=A0 And now, who'd want to be a fs maintainer with the autom=
ated
>> > harassment?
>
>The problem is that peopel are *believing* syzbot=2E  If we treat it as
>noise, we can ignore it=2E  There is nothing that says we have to
>*believe* syzbot's "decrees" over what is a security bug, and what
>isn't=2E
>
>Before doing a security assessment, you need to have a agreed-upon
>threat model=2E  Another security aphorism, almost as well known this
>one, is that security has to be designed in from the start --- and
>historically, the storage device on which the file system operates is
>part of the trusted computing base=2E  So trying to change the security
>model to one that states that one must assume that the storage device
>is under the complete and arbitrary control of the attacker is just
>foolhardy=2E
>
>There are also plenty of circumstances where this threat model is
>simply not applicable=2E  For example, if the server is a secure data
>center, and/or where USB ports are expoxy shut, and/or the automounter
>is disabled, or not even installed, then this particular threat is
>simply not in play=2E
>
>> OK, so now we've strayed into the causes of maintainer burnout=2E  Syzb=
ot
>> is undoubtedly a stressor, but one way of coping with a stressor is to
>> put it into perspective: Syzbot is really a latter day coverity and
>> everyone was much happier when developers ignored coverity reports and
>> they went into a dedicated pile that was looked over by a team of
>> people trying to sort the serious issues from the wrong but not
>> exploitable ones=2E  I'd also have to say that anyone who allows older
>> filesystems into customer facing infrastructure is really signing up
>> themselves for the risk they're running, so I'd personally be happy if
>> older fs teams simply ignored all the syzbot reports=2E
>
>Exactly=2E  So to the first approximation, if the syzbot doesn't have a
>reliable reproducer --- ignore it=2E  If it involves a corrupted file
>system, don't consider it a security bug=2E  Remember, we didn't sign up
>for claiming that the file system should be proof against malicious
>file system image=2E
>
>I might take a look at it to see if we can improve the quality of the
>implementation, but I don't treat it with any kind of urgency=2E  It's
>more of something I do for fun, when I have a free moment or two=2E  And
>when I have higher priority issues, syzkaller issues simply get
>dropped and ignored=2E
>
>The gamification which makes this difficult is when you get the
>monthly syzbot reports, and you see the number of open syzkaller
>issues climb=2E  It also doesn't help when you compare the number of
>syzkaller issues for your file system with another file system=2E  For
>me, one of the ways that I try to evade the manpulation is to remember
>that the numbers are completely incomparable=2E
>
>For example, if a file system is being used as the root file system,
>and there some device driver or networking subsystem is getting
>pounded, leading to kernel memory corruptions before the userspace
>core dumps, this can generate the syzbot report which is "charged"
>against the file system, when in fact it's not actually a file system
>bug at all=2E  Or if the file system hasn't cooperated with Google's
>intern project to disable metadata checksum verifications, the better
>to trigger more file system corruption-triggered syzbot reports, this
>can depress one file system's syzbot numbers over another=2E
>
>So the bottom line is that the number of syzbot is ultimately fairly
>meaningless as a comparison betweentwo different kernel subsystems,
>despite the syzbot team's best attempts to manipulate you into feeling
>bad about your code, and feeling obligated to Do Something about
>bringing down the number of syzbot reports=2E
>
>This is a "dark pattern", and you should realize this, and not let
>yourself get suckered into falling for this mind game=2E
>
>> The sources of stress aren't really going to decrease, but how people
>> react to them could change=2E  Syzbot (and bugs in general) are a case =
in
>> point=2E  We used not to treat seriously untriaged bug reports, but now
>> lots of people feel they can't ignore any fuzzer report=2E  We've tippe=
d
>> to far into "everything's a crisis" mode and we really need to come
>> back and think that not every bug is actually exploitable or even
>> important=2E
>
>Exactly=2E  A large number of unaddressed syzbot number is not a "kernel
>security disaster" unless you let yourself get tricked into believing
>that it is=2E  Again, it's all about threat models, and the syzbot robot
>very cleverly hides any discussion over the threat model, and whether
>it is valid, and whether it is one that you care about --- or whether
>your employer should care=2E
>
>> Perhaps we should also go
>> back to seeing if we can prize some resources out of the major
>> moneymakers in the cloud space=2E  After all, a bug that could cause a
>> cloud exploit might not be even exploitable on a personal laptop that
>> has no untrusted users=2E
>
>Actually, I'd say this is backwards=2E  Many of these issues, and I'd
>argue all that involve an maliciously corrupted file system, are not
>actually an issue in the cloud space, because we *already* assume that
>the attacker may have root=2E  After all, anyone can pay their $5
>CPU/hour, and get an Amazon or Google or Azure VM, and then run
>arbitrary workloads as root=2E
>
>As near as I can tell **no** **one** is crazy enough to assume that
>native containers are a security boundary=2E  For that reason, when a
>cloud customer is using Docker, or Kubernetes, they are running it on
>a VM which is dedicated to that customer=2E  Kubernetes jobs running on
>behalf of say, Tesla Motors do not run on the same VM as the one
>running Kuberentes jobs for Ford Motor Company, so even if an attacker
>mounts a malicious file system iamge, they can't use that to break
>security and get access to proprietary data belonging to a competitor=2E
>
>The primary risk for maliciously corrupted file systems is because
>GNOME automounts file systems by default, and so many a laptop is
>subject to vulnerabilities if someone plugs in an untrusted USB key on
>their personal laptop=2E  But this risk can be addressed simply by
>uninstalling the automounter, and a future release of e2fsprogs will
>include this patch:
>
>https://lore=2Ekernel=2Eorg/all/20230824235936=2EGA17891@frogsfrogsfrogs/
>
>=2E=2E=2E which will install a udev rule that will fix this bad design
>problem, at least for ext4 file systems=2E  Of course, a distro could
>decide to take remove the udev rule, but at that point, I'd argue that
>liability attaches to the distribution for disabling this security
>mitigation, and it's no longer the file system developer's
>responsibility=2E
>
>						- Ted
>

The noisy wheel gets the grease, and bots, especially ones with no kind of=
 data organization, can be very noisy indeed=2E So even a useful tool can i=
nterfere with prioritization, and in particular encourages reactive rather =
than proactive scheduling of tasks=2E
