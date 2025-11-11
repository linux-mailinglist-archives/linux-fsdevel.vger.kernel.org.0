Return-Path: <linux-fsdevel+bounces-67900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA01C4D095
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 11:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0B53188F432
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 10:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA5734D931;
	Tue, 11 Nov 2025 10:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="q4HHA45X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8FB2F546D
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 10:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762857008; cv=none; b=eu01A3WBvFRgTklBZh4RC2PTC0Tki8+Knr3RAkz2CsjQ/B8ymuy9IJ8Tg89rtBpFV+LncT1IK25LzAvvDdvA6u9SdH1Hinz2auj7oIAYNpn1suJw7D5VeLgItY0OVsSKVizVQ1Yyl8yYac2O0JxRE8D/mA4NXBNjSmyh0bFgNuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762857008; c=relaxed/simple;
	bh=ErpvLu+msmOQH+DLoUzEraHYQEPe7HwAu5dxR8qbtAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F9CatfJb63f5T2MYafj68lOllwxUxbtaj1StB+gh/4bRgsdPaSqqD7gYBOjdYMTodE757Vl7rjXVVl4/WVBBVoFFuhKdSfO0pzCgZ+kGDfAu3Jayk0kRBRgj4OX3lquJsC6gmLQIe6YpjVjVcgbkXIpEE/JBCYF/EXBfQD4Y07w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=q4HHA45X; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4e4d9fc4316so40133711cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 02:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1762857004; x=1763461804; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ErpvLu+msmOQH+DLoUzEraHYQEPe7HwAu5dxR8qbtAo=;
        b=q4HHA45Xx0xTDskll4DjSU6SWhWolRSlpTtA8cDnYPTI/9mbRIiB52rjVByj7Xz8ay
         nFP0//QDDttEQdXDUPTQYuhtZxg4E9Z6etcMAQhjvLkWtzN7d8du6hlQT4fTRYhV57g2
         fSGQ47hY+Biwn3/0+lGUjV8ol/iJevVJFrQy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762857004; x=1763461804;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ErpvLu+msmOQH+DLoUzEraHYQEPe7HwAu5dxR8qbtAo=;
        b=Zx1T4DVw5ZFl1OdiKIGzlWvh1BJrOKqMkKMXZPzhJl8kVQvIVt4AeAMF8YZDfQZDA5
         YOz5qb5x+ea3xP8YOvlq4enYBBsuZ6aU4SMNMxu9UFC5MrmbQv9b3Wrovqr5LczsEfTm
         dhMRz0OCO5YCToZhsd45MqPorjFKq8yS2KsA8aTNbOLHlirKC6hsNcS1Kp0KYs5d3s0/
         ybyZ/oRMfM0o4IKfOUfz4mYapoOJUQX4OPRay3w0FWHucyokgBikq4T0VBOOH7TKrNMM
         LqtSSqwFNQuHFozbDeN3SSI3XVJ+nf0d2PMBOoRgLHuUbun84XwWZGpQ//wNiQ7ipR42
         +eyQ==
X-Gm-Message-State: AOJu0YzEGu6aABPRPaMBWF0H2arXxktNcc/UttCecOZcsUX0TsQ1F0aq
	bfir0gRtrdisgjPQLEZkJ1s+PJo2cwwcAuUgklafeuyEGl6JW8PlXQVO23Va9cnitu3d/Zr48fl
	TwsJ6rZSZrTDGOMSzkn5nOgQumQJ5ShydnB/NHEfR+Q==
X-Gm-Gg: ASbGncs4pgSKE0+WNA3rHXMA/1EOqa+CqiN8OYJSQdru6GWMrkhPdT8wNOZhWIn0u1b
	vQpG4S7nvj0JnNDYhItpsEvJqxmDO19le/Z7oBvA/+v8o9bOvwTYNoNwdInjyhXji8C3lnFS8oF
	yzp7M6nqmpqG/ct3al1MT4cn+Xmh60aPAp/7EFBxE6Nd1ssH/zEJ0eQIGqAEsaAwsMzhRYsPDgc
	wHi9yr72KNUZbXD0pZ/17HKUOzvFVm9/Bp/cipmnfBItO3xea0j38ZTuRogeC3/dRxbVw==
X-Google-Smtp-Source: AGHT+IG1vPc79jE1NxMTWUcAkMOFXJ1dO7xwNLHncVzXeQGMi6M4ZcaWG7wZ9Wn4xgn8RqaQcm4UKxcrnMz8XFw/71I=
X-Received: by 2002:ac8:7d8b:0:b0:4ed:b378:145d with SMTP id
 d75a77b69052e-4edb3781c5fmr87056701cf.45.1762857003684; Tue, 11 Nov 2025
 02:30:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111065520.2847791-1-viro@zeniv.linux.org.uk> <20251111065520.2847791-4-viro@zeniv.linux.org.uk>
In-Reply-To: <20251111065520.2847791-4-viro@zeniv.linux.org.uk>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 11 Nov 2025 11:29:52 +0100
X-Gm-Features: AWmQ_bnbS5BGnOdlDcNli2J3_mWe2QdNv2AalQvWZZg8jjhCbQzLKZqYiVdFPQQ
Message-ID: <CAJfpegv5eZK=70GEdbofg8u-CKS7gL6Ur5PD86Ay4h3Z8D986A@mail.gmail.com>
Subject: Re: [PATCH v3 03/50] new helper: simple_remove_by_name()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	brauner@kernel.org, jack@suse.cz, raven@themaw.net, neil@brown.name, 
	a.hindborg@kernel.org, linux-mm@kvack.org, linux-efi@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, kees@kernel.org, rostedt@goodmis.org, 
	gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, paul@paul-moore.com, 
	casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Nov 2025 at 07:55, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> simple_recursive_removal(), but instead of victim dentry it takes
> parent + name.
>
> Used to be open-coded in fs/fuse/control.c, but there's no need to expose
> the guts of that thing there and there are other potential users, so
> let's lift it into libfs...
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: Miklos Szeredi <mszeredi@redhat.com>

