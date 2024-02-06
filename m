Return-Path: <linux-fsdevel+bounces-10438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BC884B272
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 11:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75D241F248FA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 10:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634CA12EBC1;
	Tue,  6 Feb 2024 10:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AfwUCx/D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D3C12E1EC
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 10:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707215028; cv=none; b=Gfo/guoVaDjzXSiT1a3IgxYsJjX4T80dkH9+ah+KX5bUzw4BfbuXBKzNC9ouTQod1Pz91NUQ1hHyT4FvfydRv7LDpWVDr+ZZeDaJTbcsAAUJNC4lw0HEONkm1GW2K1uSTKq+dSgaY3uNgugJlkisqF1GLOsV3ismfyCOqC+fHbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707215028; c=relaxed/simple;
	bh=JQc7I9dtacgIh6dzApcTtL71VyIWn4aWCD9+Rsus/uU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OIqSoo4tjjX9Mow8PZmwEV9QbDx93TDg8r6IfuhOdW7odKiuag7cgCDAUxXDoAt/BEf3gypT+luDeJlzWN/RPOdEvdNPJMtLrggLTDDPOqzZPijqZ3E3LqoHDaydNoO1J/YcnEPDQ2a1s2IEmfySrAuwOtjPjneL0YCyheFecJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AfwUCx/D; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4c033928deaso299005e0c.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Feb 2024 02:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707215026; x=1707819826; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DvZiY9ihexG/Lq+UzYShBWDLaHBQcaLwobbBS4o9zoI=;
        b=AfwUCx/DJRNaiaKS1iipnlPsd5rZMmrz3I0s+8EEhKEvO4fZfrHxyhbJE3BovUA43g
         9tpanRMVnVovsVs3uMjdIu3BWWQRlDzKwCEQa8NaLkKDHYmX+l4DiEJscEkTeSynMpdq
         OOoiFliI+RBOdL6G2hSQpVC9qiI8wPPo+sNZeHE5Ebp+V5AiUEcHGcFQXl8dJylkzs2l
         Gogs5RDRwN09qnCUXn9vG32/kXPxcO78z+ipLk8WsqQvi9Knni5kArfFxxxWkndCrdDH
         Ugju7rBdGrXx5U4xXLXZPUydxBc27pQKhw1DvuXULYMuTlmqPVLF/DG+A+3lo7CJ0Cuh
         rf6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707215026; x=1707819826;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DvZiY9ihexG/Lq+UzYShBWDLaHBQcaLwobbBS4o9zoI=;
        b=bIg+XUMiGxD9VDunop55kbNVKSmNDcT2/MYdUSJDLDtnhNv1GexeJw/g+o7TpFH7h4
         Nw9WwHuC6vG7orvdG5izlSr5FBuo+ilWMfsCKvdlYa9rRrLPaoSKVEee8lNKONYyUvTB
         Uaeid6bvGJQcwceahERdT0fXcvmGf/VcBBIAXr8BQHv7HBEvuLEHuqBycPsHP+H0nnG7
         /FgkRvWeSgkE6r7mUhNLk9+HlP3scxH15QmrSZ7WxJoGYUyYvSWjcLiVTOE36DAU4lhn
         LWZb9R2ZYwDw7pKao6N6tjv5og+eLMda38+MSjPWyRuOgn6sofg0rJPHUpJ7N5RK5Xw+
         ZHVQ==
X-Gm-Message-State: AOJu0YyauAEvT5rMD68sPB/RIpAlVEKlBJhgBZZBRSBsvK2urxV7wIBd
	9lG4D7YaAUvNN9vnICkHlkjYOPnZVFxegmAcbiiJ09wfADDtCDIbDW+jL0S/BvK16chHVSnda+4
	w5mWBsAmLtItwMYFxgkdWFfZ3duTLpL/Rhicm9Q==
X-Google-Smtp-Source: AGHT+IGfDOnd2EhP4TWByrQOkcid9KL+1EpEAi8LxcA+nJejScdKhoTZckC004/fc+VBarRks/cvEIzLg7CHcNC2TZ8=
X-Received: by 2002:a05:6122:17a8:b0:4b9:e8bd:3b2 with SMTP id
 o40-20020a05612217a800b004b9e8bd03b2mr1876525vkf.2.1707215025681; Tue, 06 Feb
 2024 02:23:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYttTwsbFuVq10igbSvP5xC6bf_XijM=mpUqrJV=uvUirQ@mail.gmail.com>
 <20240206101529.orwe3ofwwcaghqvz@quack3>
In-Reply-To: <20240206101529.orwe3ofwwcaghqvz@quack3>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 6 Feb 2024 15:53:34 +0530
Message-ID: <CA+G9fYup=QzTAhV2Bh_p8tujUGYNzGYKBHXkcW7jhhG6QFUo_g@mail.gmail.com>
Subject: Re: next: /dev/root: Can't open blockdev
To: Jan Kara <jack@suse.cz>
Cc: linux-block <linux-block@vger.kernel.org>, 
	Linux-Next Mailing List <linux-next@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Linux Regressions <regressions@lists.linux.dev>, linux-fsdevel@vger.kernel.org, 
	lkft-triage@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Feb 2024 at 15:45, Jan Kara <jack@suse.cz> wrote:
>
> On Tue 06-02-24 14:41:17, Naresh Kamboju wrote:
> > All qemu's mount rootfs failed on Linux next-20230206 tag due to the following
> > kernel crash.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > Crash log:
> > ---------
> > <3>[    3.257960] /dev/root: Can't open blockdev
> > <4>[    3.258940] VFS: Cannot open root device "/dev/sda" or
> > unknown-block(8,0): error -16
>
> Uhuh, -16 is EBUSY so it seems Christian's block device opening changes are
> suspect? Do you have some sample kconfig available somewhere?

All build information is in this url,
https://storage.tuxsuite.com/public/linaro/lkft/builds/2byqguFVp7MYAEjKo6nJGba2FcP/

- Naresh

