Return-Path: <linux-fsdevel+bounces-33659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E56C39BCBE7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 12:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A958C2826EE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 11:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7601D0942;
	Tue,  5 Nov 2024 11:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rw/nXfKW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18C01D4326
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Nov 2024 11:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730806226; cv=none; b=kooaMsGrwCj+h0VIgoGPhtMIzN46cPLC9Muo+LoSke6W+zEy3iDNumm3y7qV2Hx0J9MWhPoSpVFKJWHV83mpnrw3KNTDIZVKnQlAqb5vy1hBYkFRlo8gidC+21l67qP1ucrq2skTRtBqS9mDcq6mNrM+Q+TLNRc+nJTH+xhgZVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730806226; c=relaxed/simple;
	bh=m7frp/0fBAfYOItMFTFVKTQDKRm1t3LtUyiGru/T0AE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rai+N64U+Op9yEPMBSSvrabEIGS+x4gaCUvk6f8f7GqiBO+ZAjtUwZ3kSh++P6xaC8BPSRYlo2UQKj7Hfxjkqiq8EQPddFXkdLEpVqqpL2iZLZQOqhHzHMGOR9Vu5kApB/Qc4bctvYegPkmAw+ukUEdnqsF5+xR2Tp9yYYRMqqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rw/nXfKW; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53b13ea6b78so8356253e87.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Nov 2024 03:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730806223; x=1731411023; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ULjdb1z4hvBc3B/uvWTCeqNt7HFogThnf3cG0eedTM0=;
        b=Rw/nXfKWfgxNgCqFGSGt2KyzVFT5bw/1lgv6/L7cin8lyYM1LOKEkKnlZF5eX46O+y
         /fZ5NSFRSWlM8LpfVD3aIhD/cdbBmkSRYnlPVV+8qMLYmuLvhIu4xxaCbdpHMOZ9ioS2
         E/hkW77QFfMwkSNdXv2wwFF+HoHzUQlkU1wis7lopRPzyZzlNz9zh3+zJaWf6GJoVC53
         VHltzSaZVtlWE1SKT6U+PkekCZgioit7AY5PPzdTwyDQ6eHpobB4R6F7JY53jRhSpFBD
         rd6atTOjJ23pCEHhaueirUpxCtOcKFBC9Rt94VQXodHDLlkpAKf0aKOyhtLa2/blhMPX
         eKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730806223; x=1731411023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULjdb1z4hvBc3B/uvWTCeqNt7HFogThnf3cG0eedTM0=;
        b=RBonxwKbv8OVP+E29V5FfFpZ8RQjy5JsIBS1S/yZgHBm8NWztyekXRIrlqH6o1zWSs
         hvQoQC+MI4mJcR9EcneQnPyWTQU8BBdt05pOElh2UYcvPV/Yc2khywMgHIynzUcla1zz
         MLdYlQsF1jVMyTy6ByHF7+gH3ByC+ZJhTQxREGaSd3XYeVtJXKKuCcM6o51xtKKWE3OK
         /cjvOo7vlimUnsZsR9gb4hHvAxyGr14jrHH832NH7Vxi+G0qJiP9C85U6s4yzP9xpPwE
         M7TKvbF6jRWznXylGGVG+oJwbIdrwJVq4vUaGbuzMWDpWnoQUf/rogh2G3ZaNqAvjcKA
         OUEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHhUixkf4JNOm2rbsyhSC6vp0U2vPMai/kMNe0sZcDOcCHisvrl9XZHTk4gtRwtat1K31dWtGdqZFHiPQJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzZlKSpG9H3Iycc0hj723MORL0OHPm+8PtB4GiUVCUEUy+ASUKi
	LPeo7BZa/G/FZe6ISFaDSHUPjjvv5slVx3YdYMkootyQ4BlyYdCn
X-Google-Smtp-Source: AGHT+IEewzjwOUa0rMORv/qSPbFJcOM2J3M+HuEFHZyl6X8ycGs368CdUauiNcXUll3WZidrqOWd5A==
X-Received: by 2002:a05:6512:3e0d:b0:539:f10b:ff97 with SMTP id 2adb3069b0e04-53d65e16242mr11530316e87.49.1730806222463;
        Tue, 05 Nov 2024 03:30:22 -0800 (PST)
Received: from f (cst-prg-73-86.cust.vodafone.cz. [46.135.73.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb17cea97sm121225466b.115.2024.11.05.03.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 03:30:21 -0800 (PST)
Date: Tue, 5 Nov 2024 12:30:09 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Tycho Andersen <tandersen@netflix.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, lvc-project@linuxtesting.org, 
	syzbot+03e1af5c332f7e0eb84b@syzkaller.appspotmail.com, vbabka@suse.cz
Subject: Re: [PATCH] exec: do not pass invalid pointer to kfree() from
 free_bprm()
Message-ID: <m4ws43n63iaxuyx7qm667ppsloc63aex34erarrflp6huzlaru@xrpnve3kjluy>
References: <20241105111344.2532040-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241105111344.2532040-1-dmantipov@yandex.ru>

On Tue, Nov 05, 2024 at 02:13:44PM +0300, Dmitry Antipov wrote:
> Syzbot has reported the following BUG:
> 
> kernel BUG at arch/x86/mm/physaddr.c:23!
[..]
> Since 'bprm_add_fixup_comm()' may set 'bprm->argv0' to 'ERR_PTR()',
> errno-lookalike invalid pointer should not be passed to 'kfree()'.
> 

The specific instance aside, perhaps kfree could get patched up to
complain about it (when debug is enabled)?

