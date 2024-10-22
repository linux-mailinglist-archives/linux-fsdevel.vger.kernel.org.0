Return-Path: <linux-fsdevel+bounces-32583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFC79AA198
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 14:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBAC91F236B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 12:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765A219CCEC;
	Tue, 22 Oct 2024 12:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="CcQSeACI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99431199252
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2024 12:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729598422; cv=none; b=IMWjLHnNe24AAR/E+mypc7GAHqCeYrnHpl4p8XgiGyZHPxM+M/7Lj7w/vzjmQjyDmHzABdk07XAD7D7R4xeQXG3P8n9jJWa7k1W39pkuvx++L/Eovhj+DCoR1Gekh4OheYpCAtnoM8nVTUvlij46bJL1gYCo4PpL6TjT9DUdBXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729598422; c=relaxed/simple;
	bh=DiffitXSu3q4aybGs9Cn1s6e2cnctKUCP5vyccxptgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lTuzd3tjM75qiKNYKOgWyEwrbZOOdkk0nOUafydU/2HF/BbqZxq0lcSmOASQN7+XsRsAWEFtehvJjLk7JUKKvbd8wd/k9fRSyk02/udPC2U4ztUcLagzG05ohs56vK7vNftBa6zdq82k4ZOgORE0w1+PBqqeC0joeD38VFlMwTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=CcQSeACI; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-460b04e4b1cso30205451cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2024 05:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1729598419; x=1730203219; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DiffitXSu3q4aybGs9Cn1s6e2cnctKUCP5vyccxptgM=;
        b=CcQSeACILxSmY79+JEX468p/D3eS0laJwggXR1Vx54t6XrHvWwYH2/1TU6iRFb4sf6
         e9U+dPAS1dmCfQ2AjZfIE4oQUshDCh1EFYYKtJAyA1xIR/ElZ2OODsVBMEE4J1n2q7tj
         fIiGqEhi/KRIgNTaHTtN/ziEbZ3O5FkmyMedk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729598419; x=1730203219;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DiffitXSu3q4aybGs9Cn1s6e2cnctKUCP5vyccxptgM=;
        b=tCI9C7q2fMhSSUZKy5G95mMC9OT8eTHz9eIFdUg6cId/nz3IRAr4pS254DariJ5qQD
         lcAHnAiE/eK0Tk/v1obEKXAnka3lADzeSmepZwhirUirEtRNY8i2mMDjpjjvKxYucEnx
         sBfWFCHT7Pl3kRUZ39UcIbaPnG9UboZtudl/oH2aVpb6sOI5Een7AixMnDDSdfq0MB3V
         e54sCf25Zl/8LgnMM0piqEVxJ610XO8KQEuuBoUJDlU9ACPxcPLT3YdV7z7vwUnKOO5S
         78wuqyBlpll2XZJcRumNfGHZnW9NESgG9GfdZvrwiCjmnr1gcReUMNVjEREsilyKa2T/
         C+sw==
X-Gm-Message-State: AOJu0YyQbKsjVKCn4d27MsQV6u4NAcceq9cB+MKD3bpehIX/XAXO1vPn
	1n4848vzz3LaOSF4BRchBxDqEt3/DTeQ3jTmZCQMpdew9DHzZrAu4TM6sTKYmfHwYPUC3xh6PW3
	IewqGxUpfjt/+uPFpOV4U/qeIsHxYf2aEFlgDHA==
X-Google-Smtp-Source: AGHT+IG9IY5lCN/KKIwSNtjspiRh+GuoZG7tuF/osqrqiSNPMuUSVe/lzomYwLUtFhE58ZQmncRkLGo6BJUnoFdmm5o=
X-Received: by 2002:a05:622a:5499:b0:458:4a68:7d15 with SMTP id
 d75a77b69052e-460aee2c490mr176091071cf.44.1729598419272; Tue, 22 Oct 2024
 05:00:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021125955.2443353-1-houtao@huaweicloud.com>
In-Reply-To: <20241021125955.2443353-1-houtao@huaweicloud.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 22 Oct 2024 14:00:08 +0200
Message-ID: <CAJfpegv6KG92O875p0+5rm1bMb=pb8eyorhkpg4Xroo+BGpW0w@mail.gmail.com>
Subject: Re: [PATCH] fuse: zero folio correctly in fuse_notify_store()
To: Hou Tao <houtao@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	linux-kernel@vger.kernel.org, houtao1@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Oct 2024 at 14:47, Hou Tao <houtao@huaweicloud.com> wrote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> The third argument of folio_zero_range() should be the length to be
> zeroed, not the total length. Fix it by using folio_zero_segment()
> instead in fuse_notify_store().

Thanks, folded into the original patch and pushed to #for-next.

Miklos

