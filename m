Return-Path: <linux-fsdevel+bounces-71364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D981BCBF560
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 19:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 073B53028D96
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 17:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4B332549B;
	Mon, 15 Dec 2025 17:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWcISiYv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CEA3242B5
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 17:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765821585; cv=none; b=m9Ji9LNfQG65hfkS84lHOdmcXewuabniY/7mKio/QEk7s41OQTO1AEuqrdJsD04oTkamOTH9gZFy//J1GJYfKhr9OcbrdVde2zqQ2eVrLBfH0w/rLzYXtU3pAgwPM83DR/31rR9iZUdDCWNHcT8F97iayIKqjlcAxKDODjMetMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765821585; c=relaxed/simple;
	bh=rKVKnsmZY5Zk5WseCbLhC70tZU73oYSI0ZX68nvqOpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NjKoE5tXBKpkgH4HMHU0Eo6bUMelDwcqfCqXT6E/g5Pjq/g4eZtDwGdXusHWVzgwR5MIYuAWMjEcuHEbomTsRdGWHsTGVAKCONSfyDgHAMGItXGPREgcXrqQXumoMj+9qcDKp7IwIJS/kRlsoVfWcM8G49GAfLTgaHTbY7LnXeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWcISiYv; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-597c83bb5c2so3248218e87.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 09:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765821580; x=1766426380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIbn2oDFRSGWfD5W22SaWrURpraJkYSQ1nm0bbeV7eo=;
        b=mWcISiYvQDMyWrcSRycAfbgC2LcfDHeiHNEwlrIHZIiej1AYC1xSGsNIQAQ09hrYkV
         JX5RKvAXPuBpvT42pleeeJWKLBH2sgmOEqfv/KpJmG2j4MZwEb/VhmN2KUWZSKmpR4y8
         W9Y9TRYiK/LUJSWBxJeCtVm6+grs9CMML+9OjkE4C8237semIawFtJN/0+n1tfa/B4sH
         4PXZxM7CBczsbeXD5LrxS/cB7X27CZ/SgFLeQqgNRSooR0u6fqf5viqD1bfmET98d1BJ
         y+OTGkBGOVpj54S8EoEEBS6SOazJkp5BEh/6fqKDGAxYCvW45iAXLY5VypDKgUjIZ0ta
         NCVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765821580; x=1766426380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zIbn2oDFRSGWfD5W22SaWrURpraJkYSQ1nm0bbeV7eo=;
        b=O9IQWcM8v32MjqJAEqtXj8iTfNBTNcoByEj0s/+FUamk3g9bV2uAmb+7UXoerTcQxL
         Q92WNEJB0fG5rYNrZkwimWyIlbc4JEQV42REPZmAB5wHSr2+3T80BqbxB87/c+AHw4EC
         1tJ5QGTD8feKn4gnAR5rlF/p9lfliMnbaFQUk9tp6xFiiepS1IIJ6V8xAReEMNcsH7Ig
         8fBaGbULx+QvP2HP/XYJ5nOcbZAgHDvOfRGATLV698GMfYvaBP0Nwt/L4ArSb17J7mc1
         ohLgsjcMHgypPETgNUi0xEqpMQuvMuquKQddbctiY9qshZaFFuSC8MezscFh5SFzcLm8
         tCag==
X-Forwarded-Encrypted: i=1; AJvYcCWVhx1SzZoaFLa+Km6wvSpe3JLG99WLfLMdb+idyGOvi0Y8d6ocmiB+KCFxMlZ3MM6gNWwdolj+eaRGy3X1@vger.kernel.org
X-Gm-Message-State: AOJu0YyfCuYOUSFACN/z1GG8pBpSrVTaa3r6Osh+Q0RiyAUAE8LAR4Tf
	TNLcxLMpX1PoPvj2+7In06Xx/KxVr0mTOW4QhCp1ogXkxlNNsADF/gSk
X-Gm-Gg: AY/fxX7mllZdjFqKVGWJVquFRc70yTfxF/HVu0CCyBUZqUV6mykTFaeZWLYaBd/Xwfo
	x2wFscUjLOoUK0/B5/zLpfMCOcj9M+SxayRNGSwPh9+k9SL3qORy7v+mHM3D7jkY6lshlsqejy1
	CqpjBd1qTqkzrtG77P7tJIjwc6Y+XfNQc88cr3otPYqBJOJhsi9T7YqOsCqydP9DHKTlZxqkNJI
	0pYRP/+QoFWdnq7EtX5PGnzfSa8UzH2AwNdScW3aIP5UOwLWMmw3xBQjuSIxP8aV/sJTcuXW3YF
	w+w3Ob2dgkE0tsYVSNltueIHmSRKotWZZRoz6Q+jZPpLr6i6nKfTK5rtkeTUPYB0NGRwjXSb7t8
	R+SVjVtpGYjTYJcwW0Gh8+2kiiHA/A0zrditCATn1kb3iXGURQZrKDqiP/bd4wRiYw+r0lWy1N/
	nk3lBNdXCz
X-Google-Smtp-Source: AGHT+IFsDUVoZATaLzj9N1/hjfRE03GZ2gIP+Qj4HQeX9tt2ONoJL779FMDFpau9DQULSPR5u/L2Cg==
X-Received: by 2002:a05:6512:1154:b0:597:d59a:69ca with SMTP id 2adb3069b0e04-598faa4d5b5mr3889154e87.28.1765821580147;
        Mon, 15 Dec 2025 09:59:40 -0800 (PST)
Received: from localhost ([194.190.17.114])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-5990da11dbfsm5648e87.13.2025.12.15.09.59.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 09:59:39 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: rdunlap@infradead.org
Cc: initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v4 1/3] init: remove deprecated "load_ramdisk" and "prompt_ramdisk" command line parameters
Date: Mon, 15 Dec 2025 20:59:27 +0300
Message-ID: <20251215175927.300936-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <5c3c4233-3572-4842-850e-0a88ce16eee3@infradead.org>
References: <5c3c4233-3572-4842-850e-0a88ce16eee3@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Randy Dunlap <rdunlap@infradead.org>:
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Thanks.

Thank you!

P. S. For unknown reasons I don't see your email in my Gmail. Not even in
spam folder.


-- 
Askar Safin

