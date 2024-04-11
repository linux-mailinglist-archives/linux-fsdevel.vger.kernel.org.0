Return-Path: <linux-fsdevel+bounces-16720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B252D8A1E86
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 20:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EA3CB245C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 17:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27A11BF6D1;
	Thu, 11 Apr 2024 16:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eg+yunAv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC82615532F
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 16:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712853903; cv=none; b=vB5nUhaghpWrsKaNULOqPS4yeckri0cA9avpJUhChi8tRnG8HAvXcuSG1yXhmyDYhACQ55DkRWYdbFE/+dxDp+CDmxymnZJZJ/cSvlWEUmbxcQ++9WjWJ7nQlKvAXpBF/zUfgbRwlEKJHsJpNpxkcp8y1BjoyYBwZThn5SYHYu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712853903; c=relaxed/simple;
	bh=cK3iizGgg2Qy/74GUgPzOHeak1D+hq6agfRonTQWGp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BxbpKI+a28QbO/Ix0Pz1GqJkh1TWPVWPh4VLflsRybJxTOeZAREpuNA8qssAcmck/T5kj9JBZczRuAbyt0HNFYXnvIQyko3F/x4z0ek0VL3T+f2bQ0CuqmQkbOaaT0B0aCanOH6WA9v6Wz46iYHvSCjOCr9kyVuu95VNbw2IyqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eg+yunAv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712853901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=94L/JCISmahgDBDl2sXYWYZZ3cyyrK3rK/U7jZZ3W+E=;
	b=eg+yunAvmV8R3XHL4TC+QsLRyiXE64xi33FWpryRrrO5P22YUkDGtSkJcI4ZYsp3YzKm8U
	b60iea7NRX7wmxOrgznPXttZp9Td4dxI/v2ShZE+f6CySpfNDsmz/zYJL2d9zvR/e9hoMH
	Dhjymd6OZegQaarwIAxaC/D0vwCvqRE=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-R7JEbEuxMciLVgYAqg7IdA-1; Thu, 11 Apr 2024 12:44:58 -0400
X-MC-Unique: R7JEbEuxMciLVgYAqg7IdA-1
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-4dab1c38c0cso2860e0c.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 09:44:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712853898; x=1713458698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=94L/JCISmahgDBDl2sXYWYZZ3cyyrK3rK/U7jZZ3W+E=;
        b=Z7kN5VeufeyPWER33ckzeadiu+hcrcISWUiQ/3EgglWafhmBfcoqMUf3PtfyqUFSwv
         5TDYO7BW1MEwZtv+HIUkvJhs7rjbvjOsRG63sLykgADKug7CUdxguGiw7Ulw6QuofF+l
         W3aS/X9V78u2uSfnFnih1wTIXUB/9SriX9xXLTduVg4SNd21VShKXYY/fI4HEGCmvYDp
         HcJUo7eohQACB4pXx3hvdm+Ds4eAssytVy5/1cf/TOmAafXuoDS8ozEGl9WDEsgMMxR1
         ikm5Z6Z9tKUNknKaxm5ly8e7XGGrDE23Kg7y+hmM0bUMGAqlkWypsds2Id/DQc4EOQIp
         TcLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXu2vUyl03vGoMwW55aE5CR3FV1BIo2T6dZ6az75tJ/Rud5/zqm6Fpjg4bwa14+gVKNmLu40IroTGD5cCyk9L6OauOlU3s6ueJg5sLxA==
X-Gm-Message-State: AOJu0YxiLOsenyUpS55RpJDSTMc2VjRlVevohQMGn2S93Rna+Y1JC4Tp
	Xc4UiqNAzML+O+wXPKaaW8mk1RU6WBtC8Aj1FkMalOE8oSUwNRnWNlElJKNn52FpkUe861qrr2h
	SjLPMgz7J6y1sMtSQTP3IFJzS9i0VVYdmRo8na7nhEhPNpt5Vk6Ys6le6AKjayzZox9+ySo9gOJ
	acLuEzgbCxIcW7SfY7k50wGF1byrmuZwsD8Vw6tw==
X-Received: by 2002:a05:6122:54b:b0:4d3:45a2:ae53 with SMTP id y11-20020a056122054b00b004d345a2ae53mr347665vko.16.1712853898275;
        Thu, 11 Apr 2024 09:44:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTEGaoNgtaFolCmPNWCp07NKA+2GHLVopgO1f7EIdtdwxNrvkCihwyOIj62lR0ogPYfugPwkugweibstkppTg=
X-Received: by 2002:a05:6122:54b:b0:4d3:45a2:ae53 with SMTP id
 y11-20020a056122054b00b004d345a2ae53mr347654vko.16.1712853897944; Thu, 11 Apr
 2024 09:44:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411001012.12513-1-torvalds@linux-foundation.org>
 <CAHk-=wiaoij30cnx=jfvg=Br3YTxhQjp4VWRc6=xYE2=+EVRPg@mail.gmail.com>
 <20240411-alben-kocht-219170e9dc99@brauner> <CAHk-=wjrPDx=f5OSnQVbbJ4id6SZk-exB1VW9Uz3R7rKFvTQeQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjrPDx=f5OSnQVbbJ4id6SZk-exB1VW9Uz3R7rKFvTQeQ@mail.gmail.com>
From: Charles Mirabile <cmirabil@redhat.com>
Date: Thu, 11 Apr 2024 12:44:46 -0400
Message-ID: <CABe3_aGbsPHY9Z5B9WyVWakeWFtief4DpBrDxUiD00qk1irMrg@mail.gmail.com>
Subject: Re: [PATCH] vfs: relax linkat() AT_EMPTY_PATH - aka flink() - requirements
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Lutomirski <luto@kernel.org>, Peter Anvin <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 12:15=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 11 Apr 2024 at 02:05, Christian Brauner <brauner@kernel.org> wrot=
e:
> >
> > I had a similar discussion a while back someone requested that we relax
> > permissions so linkat can be used in containers.
>
> Hmm.
>
> Ok, that's different - it just wants root to be able to do it, but
> "root" being just in the container itself.
>
> I don't think that's all that useful - I think one of the issues with
> linkat(AT_EMPTY_PATH) is exactly that "it's only useful for root",
> which means that it's effectively useless. Inside a container or out.
>
> Because very few loads run as root-only (and fewer still run with any
> capability bits that aren't just "root or nothing").
>
> Before I did all this, I did a Debian code search for linkat with
> AT_EMPTY_PATH, and it's almost non-existent. And I think it's exactly
> because of this "when it's only useful for root, it's hardly useful at
> all" issue.
>
> (Of course, my Debian code search may have been broken).
>
> So I suspect your special case is actually largely useless, and what
> the container user actually wanted was what my patch does, but they
> didn't think that was possible, so they asked to just extend the
> "root" notion.
>
Yes, that is absolutely the case. When Christian poked holes in my
initial submission, I started working on a v2 but haven't had a chance
to send it because I wanted to make sure my arguments etc were
airtight because I am well aware of just how long and storied the
history of flink is. In the v2 that I didn't post yet, I extended the
ability to link *any* file from only true root to also "root" within a
container following the potentially suspect approach that christian
suggested (I see where you are coming from with the unobvious approach
to avoiding toctou though I obviously support this patch being
merged), but I added a followup patch that checks for whether the file
in question is an `__O_TMPFILE` file which is trivial once we are
jumping through the hoops of looking up the struct file. If it is a
tmpfile (i.e. linkcount =3D 0) I think that all the concerns raised
about processes that inherit a fd being able to create links to the
file inappropriately are moot. Here is an excerpt from the cover
letter I was planning to send that explains my reasoning.

 -  the ability to create an unnamed file, adjust its contents
and attributes (i.e. uid, gid, mode, xattrs, etc) and then only give it a n=
ame
once they are ready is exactly the ideal use-case for a hypothetical `flink=
`
system call. The ability to use `AT_EMPTY_PATH` with `linkat` essentially t=
urns
it into `flink`, but these restrictions hamper it from actually being used,=
 as
most code is not privileged. By checking whether the file to be linked is a
temporary (i.e. unnamed) file we can allow this useful case without allowin=
g
the more risky cases that could have security implications.

 - Although it might appear that the security posture is affected, it is no=
t.
Callers who open an extant file on disk in read only mode for sharing with
potentially untrustworthy code can trust that this change will not affect t=
hem
because it only applies to temporary files. Callers who open a temporary fi=
le
need to do so with write access if they want to actually put any data in it=
,
so they will already have to reopen the file (e.g. by linking it to a path
and opening that path, or opening the magic symlink in proc) if they want t=
o
share it in read-only mode with untrustworthy code. As such, that new file
description will no longer be marked as a temporary file and thus these cha=
nges
do not apply. The final case I can think of is the unlikely possibility of
intentionally sharing read write access to data stored in a temporary file =
with
untrustworthy code, but where that code being able to make a link would sti=
ll
be deleterious. In such a bizarre case, the `O_EXCL` can and should be used=
 to
fully prevent the temporary file from ever having a name, and this change d=
oes
not alter its efficacy.

> I've added Charles to the Cc.
>
> But yes, with my patch, it would now be trivial to make that
>
>         capable(CAP_DAC_READ_SEARCH)
>
> test also be
>
>         ns_capable(f.file->f_cred->user_ns, CAP_DAC_READ_SEARCH)
>
> instead. I suspect not very many would care any more, but it does seem
> conceptually sensible.
>
> As to your patch - I don't like your nd->root  games in that patch at
> all. That looks odd.
>
> Yes, it makes lookup ignore the dfd (so you avoid the TOCTOU issue),
> but it also makes lookup ignore "/". Which happens to be ok with an
> empty path, but still...
>
> So it feels to me like that patch of yours mis-uses something that is
> just meant for vfs_path_lookup().
>
> It may happen to work, but it smells really odd to me.
>
>              Linus
>


