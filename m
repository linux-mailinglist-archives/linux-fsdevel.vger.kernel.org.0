Return-Path: <linux-fsdevel+bounces-9530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF078424EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 13:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25E421F26741
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 12:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39866D1CB;
	Tue, 30 Jan 2024 12:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="dOFbCfBU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1AB6D1B8
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jan 2024 12:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706617685; cv=none; b=loWNluXNfpcHXMN4VunRnIs1YSncqDvmn5tz1vv8bM2kOTFM1Tzc34XG6OvXJ0MrANDtLc8IzTf3+2SOktXouzexYAtgJVYeFBqosN1r/4Dnyl6oG9mEpUBIwoO7hnrtiqiyo/Z9vUS0GqdoOtC2JSLAnFpHRY1LqvgTonz6i0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706617685; c=relaxed/simple;
	bh=Ex8FxJ04jAdyWL0UeSXY+YnkDCB6s5bbeFoztASo4Dw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tAUOQPHUBVH8HTYkvb6So5WrXQ9+gV0AmHIMUy4/SGDJ08T/x98QyChoxA+v9ZxBCSlMebEH9qtLhtWFQHSOgXPiX4jLytjuCv13wwl1CB2vmd4c/BsROZjDGOLeUEXBS3doiNUR/CV8eHJWCqZYJ5ZnNuhJyyYvPdDxQxhLejY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=dOFbCfBU; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-510f37d673aso3229529e87.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jan 2024 04:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1706617680; x=1707222480; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0B6uRNfs4s8RGWDYXKL4Y58PZDASdfYW1vhR+y8p0OM=;
        b=dOFbCfBUey+XRrv9NCjyKvxLnPZdqNDKCnNEW1JpvVwnZMGmvU4Qr7Z4kZYlyXfw0E
         E9q7zPGEvrFgeHammgw3z/NTI+yH8sX0QxrkVO12XuHadg7HrRCTuZgWXNC5NjgcInQq
         1A+nYQqWczOMGuba7uqtkqiu3P1RHjJGqSnnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706617680; x=1707222480;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0B6uRNfs4s8RGWDYXKL4Y58PZDASdfYW1vhR+y8p0OM=;
        b=T0zIGKPNDw5VWqcjsj1pzt0Eh/qQ5+hEXWgjJKkP2xqCqPpO5CsH/oa8X4AYKCEY02
         YXsuQ5x0z2xzDPCKtr1zKux8L14k1n7C3m1y7k/DNmsEtsv9570MEEuUlc4ELkJDi9pJ
         pal5XMqRPVn1iEcWt0DxBFhd/xS8dGNsrWUutO/0OzuxwZ6xBcWJDxux3l8kAH9gwTHg
         VNYznhoKqvlqhRZwfnuomgwWkPASQBu51+z9eIGpt+H3tkAXeW/jOMj2b27GKjcHjb7R
         axqVuWHxLN5uL9Hr7R3q2fsH9t56IcXlQMo1GEpw0+Bgj8pzCbmIEnG7VjIm0loeWK3M
         3SSA==
X-Gm-Message-State: AOJu0Yy5tjOwysrBIm7+aYhc4BhmVc9Qmo5/hGcgYFmJk1Az0qbUfYhO
	9YgnI4nV3adq8UumdB0dJ9FtiTNfpfFQrO+F4SEjj9ePajQFPVG5ej5Q7P8aQsgEn0eaIsYEdj5
	p4Bjzgj8RIecPpbIFRrz/YITT1UZ3LYCtmg954g==
X-Google-Smtp-Source: AGHT+IHyHXhLm+bgLKnS1/70rp4BVRDziyplLk9Ocqs3FtrK9mFC8DfzXnCpBIsDAS+DinbzmeML9mwQCpNgtGyjsRs=
X-Received: by 2002:a19:2d0e:0:b0:510:c20:74a9 with SMTP id
 k14-20020a192d0e000000b005100c2074a9mr7009904lfj.64.1706617680236; Tue, 30
 Jan 2024 04:28:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b1603752-5f5b-458f-a77b-2cc678c75dfb@app.fastmail.com> <9ed27532-41fd-4818-8420-7b7118ce5c62@fastmail.fm>
In-Reply-To: <9ed27532-41fd-4818-8420-7b7118ce5c62@fastmail.fm>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 30 Jan 2024 13:27:48 +0100
Message-ID: <CAJfpeguF=pXwi5NGDwmdpmRzv3Bn=obL01ipO5h5xKO5pNJASQ@mail.gmail.com>
Subject: Re: Future of libfuse maintenance
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Nikolaus Rath <nikolaus@rath.org>, 
	Martin Kaspar via fuse-devel <fuse-devel@lists.sourceforge.net>, 
	Linux FS Devel <linux-fsdevel@vger.kernel.org>, Antonio SJ Musumeci <trapexit@spawn.link>, 
	Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jan 2024 at 10:22, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>
> Hi Nikolaus,
>
> On 1/29/24 09:56, Nikolaus Rath wrote:
> > [Resend as text/plain so it doesn't bounce from linux-fsdevel@]
> >
> > Hello everyone,
> >
> > The time that I have availability for libfuse maintenance is a lot less today than it was a few years ago, and I don't expect that to change.

Nikolaus, thank you for all the work you did with libfuse.  I hope you
got something in return for what you put into this project.


> I'm maintaining our DDN internal version anyway - I think I can help to
> maintain libfuse / take it over.
>
> Btw, I also think that kernel fuse needs a maintenance team - I think
> currently patches are getting forgotten about - I'm planning to set up
> my own fuse-bernd-next branch with patches, which I think should be
> considered - I just didn't get to that yet.

I hope to have a little more time for review in the coming weeks, but
this is a good idea regardless.

Thanks,
Miklos

