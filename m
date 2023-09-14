Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4757A0A50
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 18:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241678AbjINQGw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 12:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241621AbjINQGq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 12:06:46 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B204E1FD2
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Sep 2023 09:06:42 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-79545e141c7so31081639f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Sep 2023 09:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694707602; x=1695312402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WsLMEgy42yaBiT7+peH789YpkE1cZSDVdqIV9tFkDJs=;
        b=ZwiKhsSkmTCyf5TvYHer9x9UIqGqff+gaCcfpMlKqeyNEPkf5i4dYn1j452qOWD8eL
         Ll64+SLu7OMuBztJhHhkwr5KFxloQk28bGcnSoQx15Dk7xyiHmVQmd1Gv+HqtnPTKUAd
         ztB+9tFxZl8mmsJYKvWBgsU0yKcJuEOKON1kAtrYtWDBvHkwxCHzggoTgr1KP8nsMqNN
         F94gYqRCBj8KGHcY4q+e9YyRPafQOASTidXDlott5g6saGhp7TNrIWT48XDZJchwjyNT
         0qfJ0T3i1pQRbxvE6XiGTPiRBXeJizURbdID82jf9JgUK80XEf3QX6V9pR58ii49Rd0A
         OS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694707602; x=1695312402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WsLMEgy42yaBiT7+peH789YpkE1cZSDVdqIV9tFkDJs=;
        b=SHY17tFrtv7u4R36Nf5Nw61IdOA/eYtacFpINGDUgTMSWgKS3GU8BVmPFYs/Ab1y+A
         GhmJ9YGKLFlMLSUNJNMBDtZ83dcYuVh6i/rc8XcU7iZAtW6Km6knsx2UPLgRI2i6pG2V
         81Z3Ljx+Ba+gQnSfkHvbx69mfLk8oiI4r/S+GZjrVon+hMX80/x7U5CCTuDrCepgpeAJ
         MpePl0Msxx4qKO7HhwysbP2Ea+tKGy0HhZCqS93LwR+4B31Yi/gTgCuSLHh1KiUL1xbx
         r06FTPrMrnwnlJIlKdwkk27Y62fS3A51X4IzCoKq4sd5vMqV3JGYCoFCEZCduw5d2qZT
         Lx8w==
X-Gm-Message-State: AOJu0Yw8IQ3aTBJEogD4C22mTNoUQYwijgk1wg06jBI3ujA1KaW6pzjE
        qBQ7TiVFnwE6erdXFqZp+lydI5CoHVcHAqvUrFxZqA==
X-Google-Smtp-Source: AGHT+IG5uiQN1/JqfzfqQfLLWnTjs7aRdbIZbEZdBy/k86sXDjNlmcQiA459x+Nf/3/c0H14MFVFDk8eX4l2uRqCEMk=
X-Received: by 2002:a05:6602:1b09:b0:790:b44f:b9ee with SMTP id
 dk9-20020a0566021b0900b00790b44fb9eemr2328524iob.10.1694707601790; Thu, 14
 Sep 2023 09:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000007285dd0604a053db@google.com> <cbakbuszcnwtfkdavtif3lwfncelm2ugn6eyd5pd5dmdocxqh5@3op6br7uaxd7>
In-Reply-To: <cbakbuszcnwtfkdavtif3lwfncelm2ugn6eyd5pd5dmdocxqh5@3op6br7uaxd7>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 14 Sep 2023 18:06:01 +0200
Message-ID: <CAG_fn=Umt5Gm1aFa2Tr8LCXboDZvBx9WBw_AvvkN3_7eyXSsRg@mail.gmail.com>
Subject: Re: [syzbot] [sctp?] [reiserfs?] KMSAN: uninit-value in __schedule (4)
To:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc:     syzbot <syzbot+00f1a932d27258b183e7@syzkaller.appspotmail.com>,
        bp@alien8.de, brauner@kernel.org, dave.hansen@linux.intel.com,
        hpa@zytor.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org,
        lucien.xin@gmail.com, mingo@redhat.com, netdev@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 14, 2023 at 5:25=E2=80=AFPM Marcelo Ricardo Leitner
<marcelo.leitner@gmail.com> wrote:
>
> On Tue, Sep 05, 2023 at 10:55:01AM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    a47fc304d2b6 Add linux-next specific files for 20230831
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D131da298680=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6ecd2a74f20=
953b9
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D00f1a932d2725=
8b183e7
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for=
 Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D116e5fcba=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D118e912fa80=
000
>
> Not sure why sctp got tagged here. I could not find anything network
> related on this reproducer or console output.

I am afraid this is the effect of reports from different tools being
clustered together: https://github.com/google/syzkaller/issues/4168
The relevant KMSAN report can be viewed on the dashboard:
https://syzkaller.appspot.com/text?tag=3DCrashReport&x=3D144ba287a80000 -
that's where sctp was deduced from.

I suspect there's still nothing specific to sctp though: looks like
schedule_debug() somehow accidentally reads past the end of the task
stack.

>   Marcelo
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/cbakbuszcnwtfkdavtif3lwfncelm2ugn6eyd5pd5dmdocxqh5%403op6b=
r7uaxd7.



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
