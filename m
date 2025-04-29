Return-Path: <linux-fsdevel+bounces-47642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B72A1AA1BC6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 22:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC0F37A4B26
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 20:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB5C262FD9;
	Tue, 29 Apr 2025 20:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="yNxtPCwA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4337925A2A5
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 20:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745957071; cv=none; b=O6RB84gtpDa9aSUkAzc1SH87pyWxx/RYpDbzohnSd1jFwpaLZIQ60X6+KBTCbqIFLANqEMnrjew0owlZoU+gmdK9744KJCoZ/JhhOBCwP0yELeH/kEA/78woeatAIralwSPRP/Ncdx+UEypMX4YywnLpLkWHpLjic/z+uo3L72Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745957071; c=relaxed/simple;
	bh=mIDBgyIrGai5i2PevDFrQWDS2WLUPqJT0lUwwpqkZqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqtfUlWNqtfNzjGXEWy1BIsQeYvHRUqcTiercVdO1T+PcUdyNjh6qAXM9KyyLjzgydPGfJt3Edh1cePWBPooQTyXy8p4PN6XOtwEr5NSdejflExXvNS4vRm9ttnZFHFpWK4c5qmPXXU8SPWpzRobxtrmnw9wvsItJxTfB8es2bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=yNxtPCwA; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-af589091049so4897957a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 13:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1745957067; x=1746561867; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LawO1f4/ezKmBz6/weBaTcmEk8JNPzax80742Sn6nQg=;
        b=yNxtPCwAe7lD+ytg0a/9F15O/xnKFG1Gu/N7LEnq1KP4ncrUklaT3XbwjEPSyhipyD
         XdSOmI1wqi2voj0p+JmqbMnxIfpqQ4I5S27k7VJySzNKGfpncpmZIP0nQ4JdcDnV8O1+
         Hfpj2xWe1j+RF8EQ7C3mzeQiKFc6qwGkJC9d8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745957067; x=1746561867;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LawO1f4/ezKmBz6/weBaTcmEk8JNPzax80742Sn6nQg=;
        b=DY0O/YhdWyZ3NRUWpK9W36W5SuDT3lewyyvh8iQDF+zlDQB2nH6Xk8QQivXvLk8IQp
         j2iZ43JPaRlPD177bXksh1ubT8HfhRWSJ+PfW8stWRxamQJRMWhgEboqPt/9s05cUins
         w3tg4MS2a3b1aJeIraOJCERFGoJHCcaxHwHK8gCGbGscYbvs13uM4w1H+12IhqLNMDnF
         Ilt9cew93vJOsJOecqKLHmx3td8tNhAtvzB+5MvA6lVB1mTzbJmkhftrAxkIt1NrUccg
         /az3vdcxCPAbUelk7xiVrTba+cvAZ643dCo1+LeLCpusjfiEC4RFQ/cWnN51NVPXTPur
         XEBQ==
X-Gm-Message-State: AOJu0Yx3w87BqbFiioRC0VDGjAd1o9W1834Z4eUVz+3hurjT7zOvPIQB
	KwpK958OJoa6CjRDleqN+smke7ZvkGhSfaed6Bh06XqTnPvpDs6GuTu/MN8hAx4=
X-Gm-Gg: ASbGncsDy5nylJJ+/SgCI51FoJOvplkUOJEJY+I3Jubc1sd7M5Tr28JS9V43YXAr+HS
	FHV9qPWBSw8ebxBEnY8vmSE3gkxk3VnbQoTIqR6noLXaJXZtM9qAm4pVCCthRDUrXPRa+SfmSkL
	cLtdjiauELuu+FtsuHLHl6ou3H0m/sIT8yBj7MoWX10pieA4FfxIU6nPeoNx7is1lc4TozSVWRe
	WUz/glocbl53ua8N+Mk/Q0mdCvELPXsGK7NUC6EqcvQbtiHAbykiVqjtCZCPGLTkwKEpgSkz91v
	k5hxgdcHWoq5E/ckSuMBagdYzVz8DVX2Mhuu5gQRdy7x853BJXEnoE0NJxAVrf1RaEMmmAf28RU
	K2y720KMY/vxW
X-Google-Smtp-Source: AGHT+IGU1RP/mRANwzOjXe0cKgOZefEpYNYpcqI8RxMrlNXOANsV0zmRwyjxkpQy8QrrzJi5VwNW3w==
X-Received: by 2002:a17:903:4405:b0:21a:8300:b9ce with SMTP id d9443c01a7336-22df35cad23mr8306975ad.49.1745957067559;
        Tue, 29 Apr 2025 13:04:27 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4dc2119sm107243345ad.91.2025.04.29.13.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 13:04:26 -0700 (PDT)
Date: Tue, 29 Apr 2025 13:04:24 -0700
From: Joe Damato <jdamato@fastly.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Mike Pagano <mpagano@gentoo.org>,
	Carlos Llamas <cmllamas@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH vfs.fixes] eventpoll: Prevent hang in epoll_wait
Message-ID: <aBEwyNwBuihjvQ4g@LQ3V64L9R2>
References: <20250429153419.94723-1-jdamato@fastly.com>
 <CAKPOu+980gvzd-uXUARnYQ4V++08spfBVj26nZapExVF80ryYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+980gvzd-uXUARnYQ4V++08spfBVj26nZapExVF80ryYg@mail.gmail.com>

On Tue, Apr 29, 2025 at 09:28:50PM +0200, Max Kellermann wrote:
> On Tue, Apr 29, 2025 at 9:22 PM Joe Damato <jdamato@fastly.com> wrote:
> > In commit 0a65bc27bd64 ("eventpoll: Set epoll timeout if it's in the
> > future"), a bug was introduced causing the loop in ep_poll to hang under
> > certain circumstances.
> >
> > When the timeout is non-NULL and ep_schedule_timeout returns false, the
> > flag timed_out was not set to true. This causes a hang.
> >
> > Adjust the logic and set timed_out, if needed, fixing the original code.
> 
> Hi Joe,
> 
> we have been working on the fix at the same time, this is my fix:
> 
>  https://lore.kernel.org/linux-fsdevel/20250429185827.3564438-1-max.kellermann@ionos.com/T/#u
> 
> I think mine is better because it checks "eavail" before setting
> "timed_out", preserving the old behavior (before commit 0a65bc27bd64).
> Your version may set "timed_out" and thus does an unnecessary
> list_empty() call in the following block. (And maybe it can reset
> "evail" to false?)

I think it's up to the maintainers to decide which patch is
preferred; I don't really have a preference.

