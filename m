Return-Path: <linux-fsdevel+bounces-13472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E335870319
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 14:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C34E4282646
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 13:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCC33EA72;
	Mon,  4 Mar 2024 13:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XZo5KEJq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995A03E47B
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 13:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709559893; cv=none; b=n8I4+0fAt9f0HXRL/EBO67ykQSPR81XOnYNh0RAoB1I+fTC3nxKADon7Zh/v58LvDDOw0/Y6Jbqx0AYja5FUYDJOIB2uxvxw08egHZcZjQUNtQRVHy3rfBllDJCQdZTjLVE+4hbFOu9VKb/pSzv04QsD+HIYadKMZ43+Yg4fwYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709559893; c=relaxed/simple;
	bh=WYatNNPv1dfXR9HApUaPLck/xdTS5uci2N4HpAiipls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mQYG6cKAisjW3cYzrPsOKdMITM0NUnhcPmRuZw+yd2gVS4SiUiGiJoYwOjs6r+ZI01F06gKSAUqGHau+AcFkxdnaoU2j0hCiLXlMySXZCa1NlmJsh/DlwCIGkyHLkxJ2Z6FIKsz7fQcm2HOTY3yhXV5Eg1rWdtV92r0Ohfz7EEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XZo5KEJq; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-42ef8193ae6so73161cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Mar 2024 05:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709559890; x=1710164690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edjrhenNqonpGUDHiZU8SAS1zKy2+Rf2zjdCiAXt36Y=;
        b=XZo5KEJqgOl2q7HsYLlHM2nMU17F7Vbx3+QeFZjH2QiLrqN6aJwoJFfB8qhYa/pEkS
         +n0AygkD1SAyEv7pPNOhLmmAD7752pwJLOqTVKa+aJ3jsgQUqhYA0bpeN7WwcGrOyvmE
         GDLaxgsafVFD1124nh4dfZ93J0ePomRQ6tVdqK4xPvwoN5pojmfwyN8ztrhr0qHoXf1u
         bxxnFNAjmgRqXQB6QGMjj7LUpqnNgggXS5i9TDKWh/zbY3sV4vujXbRJJ/OFF75HnVhR
         6jTZ1knUej6dhO5HPhNj1zdl5l964p4Y6hklyrplcXxPLpQU6m0wHXOkIN+CW3mIcSNM
         OZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709559890; x=1710164690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=edjrhenNqonpGUDHiZU8SAS1zKy2+Rf2zjdCiAXt36Y=;
        b=U59W5XrNZWGDGfbyBO7eGMEybptlyEGXgL2u6bFrXyZPNwUhltqRtsHRFN2L/eX9fk
         6x60WC5LbhqqGxoicHS8psH/KWhbPWqdM5lv32mcEDpvtYXEG1SEo+hCcGH/rm/OKYjP
         s+bKI1dEuEZ4987QZ7cRlwG9b0J9gr3FOolTwAfA399jJ/2iKukwH/03+h0kvnKlc26+
         P4F8V1nzGMLMw3B19FpV+sIIpvXnTkTOh+vALFKCrnmcFfCwzklYcH55BGmtpcwhxuhh
         E94zUMsm0cKlRTOGZQj1OaRgfN/FgVH5nYqrekz2yAs0kE/6gI/xBe1ygajZkbL7WLuw
         bYrw==
X-Forwarded-Encrypted: i=1; AJvYcCXVobGNRY6egNA1ITmpVmQGwuiThy2YlxxzbwvTZK0Q4AVBwkmZ1XqkrbOCBoL4QqpK9kxUppjHxoqETekKGrsf8pAoUNWtuD6/Js3gqA==
X-Gm-Message-State: AOJu0YxhsTJICnbBsX2oYzUM0xEwp0y6nr8rAtlpTHHQmzRyzF6Zu46o
	wwVWUM5pUvduTnzHS6SmIfhhk3c6YWuXffMKIW+Q5U2VuFAFeRhkSER8DkQyzUFGwC6yE0e8TL6
	IOWifMYunSV8yc7Jp3aWDX/N16ye9FMqD5ek1
X-Google-Smtp-Source: AGHT+IERiVdZBoyn/IdfDoiVMAiiLMXBzhpIjtI8VIsf4pFNU+BDe+32SPFMQxPMD/HEiSxXeMpZUlBDxl+M3aCXveo=
X-Received: by 2002:ac8:1090:0:b0:42e:6de9:cd13 with SMTP id
 a16-20020ac81090000000b0042e6de9cd13mr507236qtj.3.1709559890450; Mon, 04 Mar
 2024 05:44:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <gajhq3iyluwmr44ee2fzacfpgpxmr2jurwqg6aeiab4lfila3p@b3l7bywr3yed>
 <26085.7607.331602.673876@quad.stoffel.home> <apot5wnom6wqdvjb6hfforcooxuqonmjl7z6morjyhdbgi6isq@5fcb3hld62xu>
 <2199336.irdbgypaU6@lichtvoll.de> <CAMT0RQRsdLd9dg5jkpQ+gRTn0XJe=cU5Umsjs2npyvz6pCU61g@mail.gmail.com>
In-Reply-To: <CAMT0RQRsdLd9dg5jkpQ+gRTn0XJe=cU5Umsjs2npyvz6pCU61g@mail.gmail.com>
From: Hannu Krosing <hannuk@google.com>
Date: Mon, 4 Mar 2024 14:44:39 +0100
Message-ID: <CAMT0RQQp5mdRpgJ9ae=YF1uiSr-xMHe1rAA3OnAVDnqh8Jc0HA@mail.gmail.com>
Subject: Re: [WIP] bcachefs fs usage update
To: Martin Steigerwald <martin@lichtvoll.de>
Cc: John Stoffel <john@stoffel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Can we have an option to get the output in JSON format so that it can
then be processed by whatever is doing the monitoring ?

Cheers
Hannu


On Mon, Mar 4, 2024 at 2:37=E2=80=AFPM Hannu Krosing <hannuk@google.com> wr=
ote:
>
> Can we have an option to get the output in JSON format so that it can the=
n be processed by whatever is doing the monitoring ?
>
> Cheers
> Hannu
>
> On Mon, Mar 4, 2024 at 9:22=E2=80=AFAM Martin Steigerwald <martin@lichtvo=
ll.de> wrote:
>>
>> Kent Overstreet - 04.03.24, 02:08:44 CET:
>> > > This is not the same level of detail needed by a filesystem develope=
r,
>> > > and I _never_ said it was.  I'm looking for the inforation
>> > > needed/wanted by a SysAdmin when an end user comes whining about
>> > > needing more space.  And then being able to examine the system
>> > > holistically to give them an answer.  Which usually means "delete
>> > > something!"  *grin*
>> >
>> > 'bcachefs fs usage' needs to show _all_ disk accounting information
>> > bcachefs has, because we need there to be one single tool that shows a=
ll
>> > the information we have - that's this tool.
>> >
>> > If we're collecting information, it needs to be available.
>> >
>> > There will no doubt be switches and options for providing reduced form=
s,
>> > but for now I'm mainly concerned with making sure all the information
>> > that we have is there in a reasonably understandable way.
>>
>> From a sysadmin view I totally get what John is writing.
>>
>> I know "btrfs filesystem usage" also shows a lot of information, but sti=
ll
>> with some learning it is quite understandable. At least I can explain it
>> nicely enough in one of my Linux Performance Analysis & Tuning courses.
>>
>> Commands like "lspci" do not show all the information by default. You ne=
ed
>> to add "-v" even several times to show it all.
>>
>> So I am with you that it is good to have a tool that shows *all* the
>> information. I am just not so sure whether showing *all* the information
>> by default is wise.
>>
>> No one was asking for the lowest common denominator. But there is a
>> balance between information that is useful in daily usage of BCacheFS an=
d
>> information that is more aimed at debugging purposes and filesystem
>> developers. That "df -hT" is not really enough to understand what is goi=
ng
>> on in a filesystem like BCacheFS and BTRFS is clear.
>>
>> So what I'd argue for is a middle ground by default and adding more with
>> "-v" or "--detail" or an option like that. In the end if I consider who
>> will be wanting to use the information, my bet would be it would be over
>> 95% sysadmins and Linux users at home. It would be less, I bet way less
>> than 5% Linux filesystem developers. And that's generous. So "what targe=
t
>> audience are you aiming at?" is an important question as well.
>>
>> What also improves the utility of the displayed information is explainin=
g
>> it. In a man page preferably.
>>
>> If there then is also a way to retrieve the information as JSON for
>> something like that=E2=80=A6 it makes monitoring the usage state by 3rd =
party
>> tools easier.
>>
>> Another approach would be something like "free -m" versus "cat /proc/
>> meminfo" and "cat /proc/vmstat". I.e. provide all the details via SysFS
>> and a part of it by "bcachefs filesystem usage".
>>
>> You indeed asked for feedback about "bcachefs fs usage". So there you ha=
ve
>> it. As usual do with it what you want. You can even outright dismiss it
>> without even considering it. But then I wonder why you asked for feedbac=
k
>> to begin with. See, John just did what you asked for: John gave feedback=
.
>>
>> I planned to go into detail of your example output and tell you what I
>> think about each part of what you propose and ask questions for deeper
>> understanding. If you are open to at least consider the feedback, only
>> consider, of course you can still decline everything and all of it after
>> consideration, then I'd be willing to spend the time to do it.
>>
>> Best,
>> --
>> Martin
>>
>>
>>

