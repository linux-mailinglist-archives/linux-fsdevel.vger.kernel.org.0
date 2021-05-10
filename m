Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66394379AF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 01:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhEJXx6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 19:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbhEJXx6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 19:53:58 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D114C061760
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 May 2021 16:52:52 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id r11so5873371edt.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 May 2021 16:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kx6oUauIPkvTk0qHjH/BPe+EKO5jgGnmsNTNs8OpwU4=;
        b=F21AZa/gH7HoM02tMSQcpw1ye2WThR5tWbu3jPgycC//ZTah/jhb2Eker2Pob1NzOY
         KTZN4aFjahDWC2jBl4NcPVq6/usj59m+aZD2T+vv9BA2lD9p9Y6NohofWw+QrYEIXfje
         UR0JAM/0yV4lBB4RFaDn59u8nopOcbHzeLys9DQIi3M8iu2z/sSOt1J2XB4IN8+xsAZj
         s+wV40kQ5pP7ZkRs98CGnT4dJ71FPel9+QMqcfEDzf3j+gqJDOfJLpLpCX4ewrtlIBuH
         NHkodG3ElLe4CBWni87KEyyG3ouMFQAyVgvBdAjbKSSXzLYyOIRnl8QroPNi/GHkznt5
         ULmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kx6oUauIPkvTk0qHjH/BPe+EKO5jgGnmsNTNs8OpwU4=;
        b=PV6OC6Ov/zBR4YNZEoft9BnvOAPc0xEfhnNesajg9iML0FmSlXRvsob4Cfc1WLIgM0
         mznKam3QJZ9/OP/pQBub4Tok5KzUySi4UNdc4hQlxLEuI8aNu4SfT1I0jAHxO+aRD+K2
         O6QqSPU5D2ZrpLuvRS8aHDuLBUoNLtaVLn86KSvNgb6h0UjrEDRPZACT5Onfb0v2zEgr
         hFPKGzFyYlXfH+LOICT3IbSIw97AB2ra0crJVBs3/bPM2nZXKpTu/e0yVDSgJ+Kaym6w
         kS+P9trXApNL1D9NhmQBMACruFRxhr6zouZDK0Z1OCnJZXrZSfa2KMdTqAmrG79LDtad
         6w9g==
X-Gm-Message-State: AOAM533TVNQckPk1a4X8fv90uk7dfvXqlWLzH3tAy4X5XeDT1uxbQIx+
        kB20mNoNckt5C0ByIZ+dO2VTVqyPsvuRdfXOh3Vw
X-Google-Smtp-Source: ABdhPJxWTIhe2HtbmanC5ezn2X9G/dioc2ajb3y0CBjEnZpejv+AMFdXJzAhgjSJj75EJvyNQrQazaSQR0An2wYQTCg=
X-Received: by 2002:aa7:de9a:: with SMTP id j26mr9618343edv.269.1620690771015;
 Mon, 10 May 2021 16:52:51 -0700 (PDT)
MIME-Version: 1.0
References: <604ceafd516b0785fea120f552d6336054d196af.1620414949.git.rgb@redhat.com>
 <7ee601c2-4009-b354-1899-3c8f582bf6ae@schaufler-ca.com> <20210508015443.GA447005@madcap2.tricolour.ca>
 <242f107a-3b74-c1c2-abd6-b3f369170023@schaufler-ca.com>
In-Reply-To: <242f107a-3b74-c1c2-abd6-b3f369170023@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 10 May 2021 19:52:40 -0400
Message-ID: <CAHC9VhQdV93G5N_BKsxuDCtFbm9-xvAkve02t5sGOi9Mam2Wtg@mail.gmail.com>
Subject: Re: [PATCH V1] audit: log xattr args not covered by syscall record
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Richard Guy Briggs <rgb@redhat.com>, linux-api@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 10, 2021 at 12:30 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 5/7/2021 6:54 PM, Richard Guy Briggs wrote:
> > On 2021-05-07 14:03, Casey Schaufler wrote:
> >> On 5/7/2021 12:55 PM, Richard Guy Briggs wrote:
> >>> The *setxattr syscalls take 5 arguments.  The SYSCALL record only lists
> >>> four arguments and only lists pointers of string values.  The xattr name
> >>> string, value string and flags (5th arg) are needed by audit given the
> >>> syscall's main purpose.
> >>>
> >>> Add the auxiliary record AUDIT_XATTR (1336) to record the details not
> >>> available in the SYSCALL record including the name string, value string
> >>> and flags.
> >>>
> >>> Notes about field names:
> >>> - name is too generic, use xattr precedent from ima
> >>> - val is already generic value field name
> >>> - flags used by mmap, xflags new name
> >>>
> >>> Sample event with new record:
> >>> type=PROCTITLE msg=audit(05/07/2021 12:58:42.176:189) : proctitle=filecap /tmp/ls dac_override
> >>> type=PATH msg=audit(05/07/2021 12:58:42.176:189) : item=0 name=(null) inode=25 dev=00:1e mode=file,755 ouid=root ogid=root rdev=00:00 obj=unconfined_u:object_r:user_tmp_t:s0 nametype=NORMAL cap_fp=none cap_fi=none cap_fe=0 cap_fver=0 cap_frootid=0
> >>> type=CWD msg=audit(05/07/2021 12:58:42.176:189) : cwd=/root
> >>> type=XATTR msg=audit(05/07/2021 12:58:42.176:189) : xattr="security.capability" val=01 xflags=0x0
> >> Would it be sensible to break out the namespace from the attribute?
> >>
> >>      attrspace="security" attrname="capability"
> > Do xattrs always follow this nomenclature?  Or only the ones we care
> > about?
>
> Xattrs always have a namespace (man 7 xattr) of "user", "trusted",
> "system" or "security". It's possible that additional namespaces will
> be created in the future, although it seems unlikely given that only
> "security" is widely used today.

Why should audit care about separating the name into two distinct
fields, e.g. "attrspace" and "attrname", instead of just a single
"xattr" field with a value that follows the "namespace.attribute"
format that is commonly seen by userspace?

> >> Why isn't val= quoted?
> > Good question.  I guessed it should have been since it used
> > audit_log_untrustedstring(), but even the raw output is unquoted unless
> > it was converted by auditd to unquoted before being stored to disk due
> > to nothing offensive found in it since audit_log_n_string() does add
> > quotes.  (hmmm, bit of a run-on sentence there...)
> >
> >> The attribute value can be a .jpg or worse. I could even see it being an eBPF
> >> program (although That Would Be Wrong) so including it in an audit record could
> >> be a bit of a problem.
> > In these cases it would almost certainly get caught by the control
> > character test audit_string_contains_control() in
> > audit_log_n_untrustedstring() called from audit_log_untrustedstring()
> > and deliver it as hex.
>
> In that case I'm more concerned with the potential size than with
> quoting. One of original use cases proposed for xattrs (back in the
> SGI Irix days) was to attach a bitmap to be used as the icon in file
> browsers as an xattr. Another was to attach the build instructions
> and source used to create a binary. None of that is information you'd
> want to see in a audit record. On the other hand, if the xattr was an
> eBPF program used to make access control decisions, you would want at
> least a reference to it in the audit record.

It would be interesting to see how this code would handle arbitrarily
large xattr values, or at the very least large enough values to blow
up the audit record size.

As pointed out elsewhere in this thread, and brought up again above
(albeit indirectly), I'm guessing we don't really care about *all*
xattrs, just the "special" xattrs that are security relevant, in which
case I think we need to reconsider how we collect this data.

I think it would also be very good to see what requirements may be
driving this work.  Is it purely a "gee, this seems important" or is
it a hard requirement in a security certification for example.

-- 
paul moore
www.paul-moore.com
