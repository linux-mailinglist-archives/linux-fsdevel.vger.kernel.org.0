Return-Path: <linux-fsdevel+bounces-40363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CED4EA229CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 09:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4558D166B37
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 08:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E647F1AB530;
	Thu, 30 Jan 2025 08:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="IHE+l9rT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542F718FDC5
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 08:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738226769; cv=none; b=qZc6OvkeJbX1MAqswFLn+pjmxjTlvgemxOF3sTs3bnlccTgKiQ5lpdzc12mzrdtLkJSd1AI2cnWES/QLzWyNcXfn+4qyWEuGYrcCDvBSrQ3sDJuvVal3bPF8dOBuIXbD6xbOKbeeUFA3BjX3Y+MEiik5XNOloQ/lLDxKdW053E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738226769; c=relaxed/simple;
	bh=aU4GUJs7Mwh1DBz/Fre2dK11BvpnjOf6+7TWTfWhuwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IBkY1ojzW/YPNyAdmLWqYUx4yyyTwDuaGt3xuRMIxSCPg7yT2iIXtwCinYKeNuyyhFcWfqaZJ+1ZRZ1dMTImp9nwHnqnl8CfWpQZVDCbA/absYncg+O8U5GbjjrXHYbyFX6xR5Hh4Yj9qqeMe99PuztEjNaGCTMp8++OFwCH1WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=IHE+l9rT; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4678afeb133so14055441cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 00:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1738226761; x=1738831561; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aU4GUJs7Mwh1DBz/Fre2dK11BvpnjOf6+7TWTfWhuwc=;
        b=IHE+l9rTk4epxMbsyL7ol3KaFbTeCZdUtOmKvPCm3f/FmrPz5zZEwwi8H2oo6LwlzR
         dhBIqMU0aHVv3LrO5U/pLnGFNgHIP43CWvSDrQLtiTQFEpQugYacpmY4y/Jt4BGwcpfY
         QQL9OnZdXuVDYvwUnBLHVX16aFBmGJC3AYHgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738226761; x=1738831561;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aU4GUJs7Mwh1DBz/Fre2dK11BvpnjOf6+7TWTfWhuwc=;
        b=UKw3rfUnSSAcSlFzgAG7LUcJdQQD12mavqMQujrY6cRa+sxd4F/OdQvLvSg6MdS48G
         VOejMmFPM7DibO2cj/bqwOKH8TXBJTH8JVmr2YJXjrBmsI7JV0E7xZeq9k83XLqrhWFP
         7JGSefgKmHn4K7i07u+F8Q/qeqShIurRqj4x5/mpFpgp8Im+N2k7OKq8VoDDvSpB+3oc
         BETfZE8N9NofX747BLYjPvjMALOl0uQsONKg3ghI6H7OANLFG3b5HSsdOIqgCVV73dZB
         AWg36yEBwmDrgw0XTrjPMVqZRRgEmSwOZLfU1Pg7MGAVWv0HzBKZYX8OrtW/9/UJwWuZ
         Vepw==
X-Gm-Message-State: AOJu0YxaLil+FQRLPgKSh9uFRr/sOFzVkamWXIObW+obuDjujjyXR047
	gpLKS+znoKVPhrNQKsuScTJr3gtJ8s+S20628S46yH4ApE7zxaeDzCutFKwdpdMcwiAp3VN1cNr
	qajNUlzfpwcKGuuG8cIwnlV9op/e5j7IMqVzC7w==
X-Gm-Gg: ASbGnctC2ljrbw/sGiHxZOc5F8LnwclTjR13QrNygGcdMMt2ba06heldHIbTtVJi3Tc
	wI719YiFQpqbx9il9d+nsx9vpJ+LXS8VZNgkTQj8+Weqjy4LqsRIl0UJ05b/ZsjF/T2Xb/Qo=
X-Google-Smtp-Source: AGHT+IFwkiXyiVy//og3DAgm7v2kHK3xAjzna0aJFf6kiYOCK5A+anJvgW7VZhCmgVl2dttn6eiAecFgEGLkvZhKSu4=
X-Received: by 2002:a05:622a:6209:b0:461:7558:892f with SMTP id
 d75a77b69052e-46fdd35fab5mr41380211cf.15.1738226761101; Thu, 30 Jan 2025
 00:46:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250130-work-mnt_idmap-statmount-v1-0-d4ced5874e14@kernel.org> <20250130-work-mnt_idmap-statmount-v1-3-d4ced5874e14@kernel.org>
In-Reply-To: <20250130-work-mnt_idmap-statmount-v1-3-d4ced5874e14@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 30 Jan 2025 09:45:50 +0100
X-Gm-Features: AWEUYZkB8Ob9LiSlsOlQT8UBkbcAxBuQWxtWJzfSzOVUrOSWhHM5hTd-xXtwggg
Message-ID: <CAJfpegsVCPfCn2DpM8iiYSS5DpMsLB8QBUCHecoj6s0Vxf4jzg@mail.gmail.com>
Subject: Re: [PATCH 3/4] samples/vfs: check whether flag was raised
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Jeff Layton <jlayton@kernel.org>, Lennart Poettering <lennart@poettering.net>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Seth Forshee <sforshee@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 Jan 2025 at 00:20, Christian Brauner <brauner@kernel.org> wrote:
>
> For string options the kernel will raise the corresponding flag only if
> the string isn't empty. So check for the flag.

Hmm, seems like this is going to be a common mistake.

How about just putting a nul char at sm->str, which will solve this
once and for all (any unset str_ offset will point to this empty
string)?

Then we can say that instead of checking the mask for a string it's
okay to rely on it being empty by default.

Thanks,
Miklos

