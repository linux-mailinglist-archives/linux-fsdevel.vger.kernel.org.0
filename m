Return-Path: <linux-fsdevel+bounces-39928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAB8A1A234
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 11:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2664216D38E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 10:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A708620E001;
	Thu, 23 Jan 2025 10:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="U3V3zBmQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758EE20D516
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 10:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737629521; cv=none; b=KW6TqDpaKVys/ssibM81sEYVk+Cw5VObdEzLMOA4u1IEtIC9y0rcB5UsSGhuY0nJg+joRpcnkv+/0yc9cSHEkALVwiX17hH/d7j78gSuJF/LoYhLYNvChl2UYgpHvOOfhD5xE25jzMcXgpsTCFkXd33ZAE0XWqZSed5ZcQwkQKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737629521; c=relaxed/simple;
	bh=64ZBKi3fVrhSq4jQLlJiPHRsTHqirJcl7b5Uyt/7Vj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hpHrPWm+iSOgH9ar2gKU6psA9Dvekjkl+7GkVerszmqoLHvWE9VMcvc2S6vu5MINtoSK3B3Mhe3e1mlG7GrlkX2ZmLT5BkmHt/HtFi4kv/Su/7NTz+sV2IkKxMZPSkBl0kQe8x/0+goQKrYHNjaxYePZmcNPyjYODkU+aCU6Zhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=U3V3zBmQ; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-467a3f1e667so4561201cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 02:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1737629518; x=1738234318; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=64ZBKi3fVrhSq4jQLlJiPHRsTHqirJcl7b5Uyt/7Vj8=;
        b=U3V3zBmQHOTOpVC7or+WO2kDmdiy1umbmtyf9HzbO9ZB3abrNB9/u9geByO9JgSc2b
         zF7iE4v41JOvOfTkwMpBJDHshs7W+3h0P9qz634hVaxkzP08wB9Q60hGe66gvDlmPDV6
         nL93y/R9E+77hrxXFDiuOmzAIp1rzsH6/LRG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737629518; x=1738234318;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=64ZBKi3fVrhSq4jQLlJiPHRsTHqirJcl7b5Uyt/7Vj8=;
        b=bGXyezcpHoH2j9crXekb2Zk9jhcaa4XsGE4+c5vAOfBc/CRY63KikN7HuGd6Vwo5lR
         sihQ/EICHqwPVZDj5v5ce3Alz1eweGl3ABAj1ewEaA122Mthk1hv2+L93RAVpivdXwOY
         5OB3ZtqUllpO0cBgdZLKnUhljQVauxA1WermqDV3WiJRedyMvIfRvEKYQ//j6RE9rPU1
         hyVaNHdQuQDv7cCIWYA9nWwz0lfS7YfN44VejqZ98lAKInnmEPkXa3faLDG+DfyGdFQ0
         YNztnM2QRfFx4g8aOmcVoaw0LMuINK/AAhsn234BlY7e175v1LDwZyIAePdxmCrLXJxe
         DmNg==
X-Gm-Message-State: AOJu0Yy9VfpVONrOHnD50jVFKFdRLTeOlYGQOIY9m4b8mMxztGby+rqu
	9+IM5ZZ4wT89vj4hMkAlUOODlc5RJVf4K8xbv1lkkPDr6ECBHG17Gl/FWbRXPQy8VScZ/ktrJWs
	yDu0VYgoMtOAN8UBWhiuU4W7FgqZZtmj1Se44/Q==
X-Gm-Gg: ASbGncvFSyisJwD3eyKjlYSHk81mUjiCZfd2VDa86eRE5/Y1ToeiWTnUnOphQd3bsO5
	vVYww8zBTrF0lW6yOVlF88pUcLsA7NyHGDJdoEvjoy42VO7RuRvwlTF0I8ldh
X-Google-Smtp-Source: AGHT+IFCQv++QsFYdqvxqu76Xx1xUMCKFnqfO8lf/2kvforDl+fXpZU9BR8rgm0yfLlAmV0bkMzjZHDetx/fmDmECiM=
X-Received: by 2002:a05:622a:1986:b0:467:76cc:622d with SMTP id
 d75a77b69052e-46e12a1ca9amr403239251cf.11.1737629518280; Thu, 23 Jan 2025
 02:51:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123014511.GA1962481@ZenIV> <20250123014643.1964371-1-viro@zeniv.linux.org.uk>
 <20250123014643.1964371-14-viro@zeniv.linux.org.uk>
In-Reply-To: <20250123014643.1964371-14-viro@zeniv.linux.org.uk>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 23 Jan 2025 11:51:47 +0100
X-Gm-Features: AbW1kvYw7DfXtx9K2u0kuT28cS6RFX0PZCipXj87ydRxCQYYo5Hopzm-X6v7khg
Message-ID: <CAJfpegvCUt3uUbbe4Y_-OHUYxP1xdgEE7F+3ecNFU-o0wh_aUQ@mail.gmail.com>
Subject: Re: [PATCH v3 14/20] fuse_dentry_revalidate(): use stable parent
 inode and name passed by caller
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, agruenba@redhat.com, amir73il@gmail.com, 
	brauner@kernel.org, ceph-devel@vger.kernel.org, dhowells@redhat.com, 
	hubcap@omnibond.com, jack@suse.cz, krisman@kernel.org, 
	linux-nfs@vger.kernel.org, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Jan 2025 at 02:46, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> No need to mess with dget_parent() for the former; for the latter we really should
> not rely upon ->d_name.name remaining stable - it's a real-life UAF.
>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: Miklos Szeredi <mszeredi@redhat.com>

