Return-Path: <linux-fsdevel+bounces-20928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F341B8FAE95
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 11:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 907FC1F255A9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 09:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DE914386B;
	Tue,  4 Jun 2024 09:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="jhl6VXAX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F051411F2
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 09:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717492735; cv=none; b=kRXYumLtHYA4DyxZ+GanO128v2L3r/oodVkReh6zL3qHpF7kA9+oouqT11NPkBU8B0TyjGJNyeXp8Ql9rs9rraOnbRtZfXxzM66jHc1X/isrkxkgoGr3Cw1Jxj0E5+bZXymJ2wbZCESHNI9aMXuT6l7t+10L5AnwpN96uIbZBWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717492735; c=relaxed/simple;
	bh=y24sg8KoLjv+41EDnW9OXIgfRUxZm78ZBUxCXzBqUnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmlK4/Aatbl0q1w8r7qjYUEqzdyTN0+xT2EWgBoaMI1ejy41UyPJAGlmZuC6SlerrCi18a41xoZCwOQf33UAIIV8iC7O9Iv3t73fIomrPxD2N1U1OaFrQPCWf/Yqtt4coxjeR4BqYJJG+iuer4z7P7JQfR6sjVFjXemDJOwcHe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=jhl6VXAX; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57a1fe63a96so4783059a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Jun 2024 02:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1717492732; x=1718097532; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fEpYJu85v46NTnKJ3KqBksM1WhwBh1dyX2mzBw78w34=;
        b=jhl6VXAXcssubLcMDFEJjrihaRDZX6cipGvAIkRLt6FQl3TthroX0c4EZ3qQwaOBCl
         Sxv4Kk3Lk0fA0ZRYZiJGy5BPyp23eef6LDAN/TV046Irnde/B5kJGO68/06ZyWXul+EQ
         Ftd9ErL8HY8KlaDVLsYOdk8CydqCuZ1ie5cXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717492732; x=1718097532;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fEpYJu85v46NTnKJ3KqBksM1WhwBh1dyX2mzBw78w34=;
        b=DQFts2/kjbo54ej60pGnjs1PEhZq2IIfeqd7R4jStgfSgX9EX+SOJwCJsufTaw+0t0
         tcMTPuvXNkME+AI4BsVMvPftxjnP7VHjm+Usa8NBXAbcZ1ebij6iNqUCdAyRCxyApOqk
         PGUzkuLZWCc4OWZjh69hEyF/J1Q2TdXqMUPltaZztKkZ2YN/SvFFudbXAndWVLlzBgIY
         vOFRLLnDiPdp0K9P9PA/HXiaiayHxUfKshLqAsw5R6T3bT/AvrADaWVUo80+w5yufGXD
         dZGfnFhG/xnTNG3zILT7Eu2IQTixYhpp9eYRMo9Hdg0flc5puazAyCj3sKhozw7C2Jqs
         SJAg==
X-Forwarded-Encrypted: i=1; AJvYcCWiSz+e4ExQ/ZfqkTDkWdwwnStOkH3WmmMMvA6G57L159MVumWxzR24XiKQ+uH2KzdW0Qq+4sAS5+FuOedtFIlbUeIEGRCYAZIJ/zpHeQ==
X-Gm-Message-State: AOJu0YwoTH9vDUDrntJSA7e78VgID8oHyyGUkspar2jra9hT9FxxEdvI
	l5+UPM74De+wv4kEPyt3thL+/ZepT2Z2Iry/OH8K/vp/6BJi6pGYni1wwucayNyn1stq6n5s7OH
	exGcOlGNTMSKesLaZiLSUCmAAg88iwZjOWDstNw==
X-Google-Smtp-Source: AGHT+IFo8j4sOBfT1n8cPC7tGx+7OLobCxi5ayAMEMDGNgh+nAaoLHPDPn7rp6lrSqaGLRRjQ0GDgHh2x0xSeqMgKdo=
X-Received: by 2002:a17:906:b20a:b0:a68:a52b:7554 with SMTP id
 a640c23a62f3a-a68a52b7810mr533041766b.66.1717492732344; Tue, 04 Jun 2024
 02:18:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SI2PR06MB53852C83901A0DDE55624063FFF32@SI2PR06MB5385.apcprd06.prod.outlook.com>
 <b55cb50b3ecf8d6132f8633ce346b6adc159b38c.camel@nvidia.com>
 <CAJfpegsppbYbbLaECO+K2xpg8v0XZaQKFRZRTj=gJc9p7swdvQ@mail.gmail.com>
 <bbf427150d16122da9dd2a8ebec0ab1c9a758b56.camel@nvidia.com>
 <CAJfpegshNFmJ-LVfRQW0YxNyWGyMMOmzLAoH65DLg4JxwBYyAA@mail.gmail.com>
 <20240603134427.GA1680150@fedora.redhat.com> <CAOssrKfw4MKbGu=dXAdT=R3_2RX6uGUUVS+NEZp0fcfiNwyDWw@mail.gmail.com>
 <20240603152801.GA1688749@fedora.redhat.com> <CAJfpegsr7hW1ryaZXFbA+njQQyoXgQ_H-wX-13n=YF86Bs7LxA@mail.gmail.com>
 <bc4bb938b875ef8931d42030ae85220c9763154f.camel@nvidia.com>
 <CAJfpegshpJ3=hXuxpeq79MuBv_E-MPpPb3GVg3oEP3p5t=VAZQ@mail.gmail.com> <464c42bc3711332c5f50a562d99eb8353ef24acb.camel@nvidia.com>
In-Reply-To: <464c42bc3711332c5f50a562d99eb8353ef24acb.camel@nvidia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 4 Jun 2024 11:18:40 +0200
Message-ID: <CAJfpegu3kwv9y1+Yz=Ad_eJt7-fNJbxgJ8m2_B=Su+Lg6EskGQ@mail.gmail.com>
Subject: Re: Addressing architectural differences between FUSE driver and fs -
 Re: virtio-fs tests between host(x86) and dpu(arm64)
To: Peter-Jan Gootzen <pgootzen@nvidia.com>
Cc: Idan Zach <izach@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"stefanha@redhat.com" <stefanha@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, 
	"angus.chen@jaguarmicro.com" <angus.chen@jaguarmicro.com>, Oren Duer <oren@nvidia.com>, 
	Yoray Zack <yorayz@nvidia.com>, "mszeredi@redhat.com" <mszeredi@redhat.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"bin.yang@jaguarmicro.com" <bin.yang@jaguarmicro.com>, Eliav Bar-Ilan <eliavb@nvidia.com>, 
	"mst@redhat.com" <mst@redhat.com>, "lege.wang@jaguarmicro.com" <lege.wang@jaguarmicro.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Jun 2024 at 11:08, Peter-Jan Gootzen <pgootzen@nvidia.com> wrote:

> Option 2 is detectable if fuse_init_out.minor < CANON_ARCH_MINOR, not
> sure yet what we could do with that knowledge (maybe useful in error
> logging?).

Using the version for feature detection breaks if a feature is
backported.  So this method has been deprecated and not used on new
features.

Thanks,
Miklos

