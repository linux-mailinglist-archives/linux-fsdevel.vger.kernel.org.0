Return-Path: <linux-fsdevel+bounces-58150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C34B2A195
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 14:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14BE73B5FA2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 12:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBE732277A;
	Mon, 18 Aug 2025 12:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="QknxQMXO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A01322778
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 12:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520113; cv=none; b=f0x8/gsxQhTfupFF8otPt3oU2WuSNrvDX4zrKr3XMpcGhPsGXX4YQnomHX10W72qcUlGe5T3UT73bR0HGYYKIYYu4btbOxIgOuIGzoq7LZWaFScuZop0jsBaE0QdYkQJHH4nqVCJEf+WNfyZ9rwPEEiutk000QsnYWzcF8HtrFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520113; c=relaxed/simple;
	bh=/tfsHKMqr8nTfKg4Ex6rYrCn/i03jqipVdnJ6D3y+jM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cELi58BSu07MM7oFFWVMOeCSurvk9zeHfLgMB+Hcu4FeQj4QDR1hGg8yitu5b2LdYy+vS6peldtitsa6v6L504E2d1qLnUqXSju4/e0jRMhlu37/V6U8y50NyPdjKQVZUHavsTk0TlASUsdJfECfgRkDn9nRLv0crorHimZImZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=QknxQMXO; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b113500aebso29297221cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 05:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1755520109; x=1756124909; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/tfsHKMqr8nTfKg4Ex6rYrCn/i03jqipVdnJ6D3y+jM=;
        b=QknxQMXOuWkZxGjgtKdFHpficqCfx4EC2QllJOMznq4HBFgNp4cI94hf6xPKcBwX6T
         5lMmXkwAv9D6vxxTTR5w/UPNOu8CvUzswndt0UtjG618WgJIVfdDIb+xY0jz2MRNp719
         FRiJSI9GHuodddPDl4231nz9ddwQqbeoVTHJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755520109; x=1756124909;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/tfsHKMqr8nTfKg4Ex6rYrCn/i03jqipVdnJ6D3y+jM=;
        b=wSS9SYmPm5GLkiUeJzPa7O+UnGu435vPDFSKAnns9WZBpBUM/i80jseo+k66fgsOWt
         6bzfKi7fVbOLH+IqOObjcKf4/J4sW1yNkU/hoJZb7bOONyszXBnsgIgb0s+x6L9RGOCP
         h3M2xUN8Jq8L1Ym7K11JkoCkUOfyUiA5YXtFtSw7B/o6e7KF1vkJoiE+J88o3jKN4p19
         opOHuDNI9B+KXvgMyj2arSnjGKn4QFaN9R/45IUNVX9hbwNR/tHXbiyqeLM/q0dmK4y5
         /Owtcws5lMuOBn1r1eiHPbakJmyhUxB2pYVtU5fFk9eoGAipOKkWBFS7JjEdc+Eut9fH
         n+kQ==
X-Gm-Message-State: AOJu0YzcIPhrpGmpxhkGoUHrNEFMf1ryFLig3azmcNRGZpPXlTvCNaJO
	Oz4XGETbPWW6EhHfLG8CMpOWdwG2RWli+B2syAmyfdQdH0tOkym/9gE3pFBMgzdY1OMQYmVbJaR
	s6hGb231J5hUKNR4+MiN6rnYSa1/fzN7W2A4c6qT7Lg==
X-Gm-Gg: ASbGncunLpQ/k/skjAWeGmUXc9/9xbZ2GcsmfN6TsHJggFNL18UeppNQ5A75iwhrCrp
	dKbphq4IIm8ltKJ31dQn8HaZj67u2JhObuOQ7+zPsfZbKQlok38/Z5WPtukkk/qZMLNH+XqNK56
	yQprfTh4S1aVD5CwgmAxguCwhO2edXv7GuUkmwFxoUfrkuHQAkH6ALuwPxLpDkmvUcLilvvVTvx
	ejulbCJ1g==
X-Google-Smtp-Source: AGHT+IETaYzj9o6mi8HTSIHcmGZ4YAGl4BNS9GKIhc6/SFw9vhRuJ8/nuysjKePoxZ+D12kQMPCu9H/2WXb1Kiwz20w=
X-Received: by 2002:ac8:7f91:0:b0:4ab:b1d5:3b77 with SMTP id
 d75a77b69052e-4b11e2b399amr170728641cf.45.1755520108954; Mon, 18 Aug 2025
 05:28:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707234606.2300149-1-joannelkoong@gmail.com>
In-Reply-To: <20250707234606.2300149-1-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 18 Aug 2025 14:28:18 +0200
X-Gm-Features: Ac12FXymHDCzlIMnSJnWCmYUd9R25CB8Q82pVKBYoFceyuXw-_2IvffVHMZ-N18
Message-ID: <CAJfpegtgiwNMpjw9vv+Bveht4f==E+HNBpoTVVM0BXQ5PjDx5g@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] fuse/mm: remove BDI_CAP_WRITEBACK_ACCT
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, david@redhat.com, willy@infradead.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Jul 2025 at 01:46, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> With the changes in commit 0c58a97f919c ("fuse: remove tmp folio for
> writebacks and internal rb tree") which removed using temp folios for dirty
> page writeback, fuse can now use the default writeback accounting instead of
> doing its own accounting. This allows us to get rid of BDI_CAP_WRITEBACK_ACCT
> altogether.

Applied, thanks.

Miklos

