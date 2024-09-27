Return-Path: <linux-fsdevel+bounces-30271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEADB988B2F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 22:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FDC6283B06
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 20:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18981C2443;
	Fri, 27 Sep 2024 20:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="K3esvp+G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585B31C0DD7
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 20:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727468460; cv=none; b=SMfxT0Qg+hQAYdm+Yjd9JcFKIQKHqvsX5+CnGvpwTjhkr22dBsIqfwwIYvJKqm6doXgJjDn0+eHsDYBJ76F2br50k/uog1PJ87iWvxxzB0MSGWfucC3I+Mw2wjt8OucDxxY6FhwN6yFsc/fFcQ+GIdLf7xLMHitlQWFRYW4lhiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727468460; c=relaxed/simple;
	bh=WyXyJQKs+LjNjZ1/xEp2xiqyDBoSLBN/sYzZZZJzDC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jseMkLal5qqSL/19hfju+cAQbxfcXm0QSP9kcM/VufY1Lpp4ESY2twEoWB5aqjFzzdB7oX4nniMwNj5rvoh69kIcjEjwcXG+DfadSmhE7/OelEGIwrVBqIGMHcss6BaCQLAdsir+B07MEEqLHh5DIEiZZRfF0kI7rMjDm34eCmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=K3esvp+G; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8a6d1766a7so324796766b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 13:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727468456; x=1728073256; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FhWlefZWZpkZ1hQiUXN4BLRYQqUrk3MN5sPdZxTFvf8=;
        b=K3esvp+GuHoICvgvuCmuTJ3U/vIU77mNSrtVNdhzDnjSDoglLJq4WgG4gTgzDtmPXJ
         17HNCsd76TdHtPwTmPHnJNEIsWlov4MnxTP2clQa23WKN7CCK2auXRqGu0wzJbqwbY1R
         cEAHPCb4SLBFRR+Rd/Du9kI8OJQQBTcb2MrD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727468456; x=1728073256;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FhWlefZWZpkZ1hQiUXN4BLRYQqUrk3MN5sPdZxTFvf8=;
        b=ifbkU2tjDwnUxNifVztwmj3zgqQnVPOGogyX7sn5Qg7ELjC5TvQI8iK7UExPqtOMvO
         f22WHl6gBlsjiC9ghIk8V9CUYwWxeCuaeZto0z1eoc2XfggRpwvNghS28h3id1jc08zv
         QspdrnjNpZ62UdD+sHrqGt3HWl03EjMhhqxNN9/vOxWroVG2xxaWIguNtqBeX8CfSzjB
         PIzb1c1LBWvm19ntfT+fEzHmXjeqH5ZSKyGqC+488XWWYm2kndVe7rDMz5BUfKT2GHc/
         Fp2k9IaWVq/o1Jzmnx1MU/4hL+fxbs1TtnMb0EozSiZyyXQJsX/+6EtFkOgjGL4MzY+0
         HdXw==
X-Forwarded-Encrypted: i=1; AJvYcCWTyTkM/SruYK+Jlu1PWSWvit8BbgwWNjF9sJCRxtIm7PhnBde475UasaFA+6vQaHwlJy5nQI1T+yFXmyte@vger.kernel.org
X-Gm-Message-State: AOJu0YyCoOEeoEmK5U0AVZJ+NaGzDZae3Tpb3PtXmnl4b4NZLFq7LHdj
	DIZf95siA+p9pGkrFzPzhNZzXK+zfIYoMLtHKwTaE3N4IYVBfuP+TmNHrUyZX/BPZXtbiWqGvkV
	oQuiM6g==
X-Google-Smtp-Source: AGHT+IFP8YPHrmmCgfypBYksZ9Mqc4Mop6TbeywMOm8n7o1228MCV02XQsUxDjEVFLobJHXNCVPwFA==
X-Received: by 2002:a17:907:3f97:b0:a86:a4b1:d2b8 with SMTP id a640c23a62f3a-a93c48f8923mr385499666b.4.1727468456402;
        Fri, 27 Sep 2024 13:20:56 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27ecfedsm172055866b.95.2024.09.27.13.20.55
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 13:20:55 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8d56155f51so296377366b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 13:20:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUVkfGI6Kr5Q7f5+kUssslAsgAVuEofEdVhgDL0feATXWhmQv9tjlyu3lyBNZpflL8fMX+l++W3JN9XVger@vger.kernel.org
X-Received: by 2002:a17:907:9604:b0:a8d:250a:52b2 with SMTP id
 a640c23a62f3a-a93c48f95c8mr413441866b.6.1727468454777; Fri, 27 Sep 2024
 13:20:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <k53rd76iiguxb6prfmkqfnlfmkjjdzjvzc6uo7eppjc2t4ssdf@2q7pmj7sstml>
 <CAOQ4uxhXbTZS3wmLibit-vP_3yQSC=p+qmBLxKkBHL1OgO5NBQ@mail.gmail.com>
 <CAOQ4uxiTOJNk-Sy6RFezv=_kpsM9AqMSej=9DxfKtO53-vqXqA@mail.gmail.com>
 <CAHk-=wikugk2soi_2OFz1k27qjjYMQ140ZXWeOh8_9iSxpr=PQ@mail.gmail.com> <20240927201522.GW3550746@ZenIV>
In-Reply-To: <20240927201522.GW3550746@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 27 Sep 2024 13:20:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjBApKY+1s7F7AB0ZnKs=SSG8jv2LMtay_MY-ym+oEKUg@mail.gmail.com>
Message-ID: <CAHk-=wjBApKY+1s7F7AB0ZnKs=SSG8jv2LMtay_MY-ym+oEKUg@mail.gmail.com>
Subject: Re: [syzbot] [overlayfs?] general protection fault in ovl_llseek
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Amir Goldstein <amir73il@gmail.com>, Leo Stone <leocstone@gmail.com>, 
	syzbot+d9efec94dcbfa0de1c07@syzkaller.appspotmail.com, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com, skhan@linuxfoundation.org, 
	anupnewsmail@gmail.com, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Sept 2024 at 13:15, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> BTW, what do you prefer for "please run this script with this explanation
> just before -rc1" kind of stuff?

Well, I didn't miss that one either (see commit cb787f4ac0c2:
"[tree-wide] finally take no_llseek out") but yes, it's probably
better to mark those kinds of things very obviously too (and a
'[PATCH-for-linus]' like subject line is probably good there too).

And hey, people will forget, and I'll - mostly - figure it out anyway,
so it's not like this is a big worry. Maybe if you notice that I
missed something, you can make sure that the re-send has a big neon
sign for me.

               Linus

