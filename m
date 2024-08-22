Return-Path: <linux-fsdevel+bounces-26693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 111D095B108
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 11:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2535282672
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 09:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6BA1791ED;
	Thu, 22 Aug 2024 09:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="pYaYtlV+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E598168C20
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 09:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724317214; cv=none; b=CybIArPzRLy89t+ZBLtIbwXwSCqiHXK6bKOv9JLFObKzIL7r8rshoFGRUKnmKOFV1vtepWZlJOONkdliRAMGffr78GDWjUuBBTYiCVgFRGD80IBWLMdMuTU+TvE+x3OHMMgWU5rj/AyD4YW+N65RQKasHCA1+aReybGU847hGPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724317214; c=relaxed/simple;
	bh=b3PxiCEc7kIl3DHgo4veoMD7JVbbi8m+YmaPJXhB+is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CCfvT5QXBw1G4InHhkvXYF2+Tt7PhzyMaJ69W4T9KjKKBIXpmwpsI5keubxsdxL3yksntO3yyrSnTWaavnZmiKCu/S/EwzpD7O1Rc6yTol2xxCnriugCB+MUrpLWHBrXVdpYdH2qzix2L8G8SyocK7woIQk+8fzrZ10jY00KU4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=pYaYtlV+; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e1654a42cb8so590836276.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 02:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724317211; x=1724922011; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b3PxiCEc7kIl3DHgo4veoMD7JVbbi8m+YmaPJXhB+is=;
        b=pYaYtlV+ArtLg8ATQLngaU1OqUHKGDN6oJdJk/QyWXYOy+EdR31fFayoyz5NlYby6w
         gLW6B0pME7mvf2k1+6ZJuB5sA31MhCGaIl1Omx6tqmsnM0Kn+0xGxKsq/iVNTC8C/zpG
         oMl/hYXi4US6vdF1Ub78D8NKi8TMAwS0jzjII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724317211; x=1724922011;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b3PxiCEc7kIl3DHgo4veoMD7JVbbi8m+YmaPJXhB+is=;
        b=dvqut57s7VoYJDNncI36XLpTZQz5sXIzG1LtMlaCxqr1T47gvm5YuHIbrR2h2CF2TG
         zyBUwCrVdkL2fIYmo3fpnkRVrvOf+2oVKj6cuCxfUc4vcOveOjqezE4Y+xM7t5vHSeDN
         5CtNE0ddvGYSKvQI6EkbYcVlKCRS5R5j43XoimolzpcLkxKRmPQiKkWs2JE9uWn7c4Gt
         Aqe2kgd5CeC4ugooxJA/2OiZZE0otaFNNK//kASHwyew6VUknj7bYIqEW7N63oYekd9K
         U1TIfmcxUU4gwmRfLhffMV5HxeDBbtDefgR79Fkhs0pC+pEWOl63TTe4b/FEqUdSo7/s
         e1+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXxSHO+kDkFvU/VxRz0iyN/RSbzHJbNHxiaYFxHg52YFU44g8y9PT0RC36ehzxR3P/AHasMGj3PWCMSXxeV@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+3bVMqM52JpDd0JEqGp73q0gasAnTfoYrHcBoV28cPJT4eYQt
	cUhf4S3nHxsfOMbn5t59MDETxTpOA8ujRsk5/ghh9ayhrSiXftJ43dPIh1Y9vusLapU6pz6NsMT
	Chwcjl/TQO0UeUzxmil+RMDA4JGoYwgEXm8xBsQ==
X-Google-Smtp-Source: AGHT+IENrQPuEOtdP7yCOlOmyspu0EZ06NFvO4PhVy4yBweMHtPXhR1W9S02Ep9VQ62K8AA64Qsb89j+aX8DLHYlLMA=
X-Received: by 2002:a05:6902:2b86:b0:e13:c773:68c2 with SMTP id
 3f1490d57ef6-e1665564fbdmr6272042276.51.1724317211154; Thu, 22 Aug 2024
 02:00:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822012523.141846-1-vinicius.gomes@intel.com> <20240822012523.141846-17-vinicius.gomes@intel.com>
In-Reply-To: <20240822012523.141846-17-vinicius.gomes@intel.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 22 Aug 2024 10:59:58 +0200
Message-ID: <CAJfpegt+M3RAQbWgfos=rk1iMu7CRhVS1Z5jHSHFpndTOb4Lgw@mail.gmail.com>
Subject: Re: [PATCH v2 16/16] overlayfs: Remove ovl_override_creds_light()
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: brauner@kernel.org, amir73il@gmail.com, hu1.chen@intel.com, 
	malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Aug 2024 at 03:25, Vinicius Costa Gomes
<vinicius.gomes@intel.com> wrote:
>
> Remove the declaration of this unsafe helper.
>
> As the GUARD() helper guarantees that the cleanup will run, it is less
> error prone.

This statement is somewhat dubious.

I suggest that unless and until the goto issue can be fixed the
conversion to guards is postponed.

Thanks,
Miklos

