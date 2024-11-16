Return-Path: <linux-fsdevel+bounces-35011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3539CFD60
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2024 09:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FE801F24492
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2024 08:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6FA192B63;
	Sat, 16 Nov 2024 08:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fnp5MNNB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01AD15381A
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Nov 2024 08:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731746530; cv=none; b=S3ofpg/rDtriBLFrY66cjWuMiGLBpP/QLog+NaFADAoiSK686sUujAhW80YQe8X4lW0Q7+UZw6wwbN7vour7wUIt2XCafkOIVJEajKut3qslOoMd/bmwVbEFm8lCKC3feHRF4Kx72gkAK4LrS2Ev2FynBE5dM8NWfYQR1ZfG30o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731746530; c=relaxed/simple;
	bh=RpFXE/zZCF8LuoyFo6xYLRzdU/hjSpEWwhXUmLgLSIw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Y2bCuYxPa52mWp+ZcDoY2g8Nf922YjRFt9NLhHFRkbGGeBcsXv277cAFmx6/teJvkY5Q2TErNH64IexekZyma3VcMYSNFbcTQnycI9v8HBjUjin0bwspfQSefQR52Qer+bZOfF23JSMQNpOwNEH7kKonhXHTLb6kQC+Al9sOb/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fnp5MNNB; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-382376fcc4fso140299f8f.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 Nov 2024 00:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731746527; x=1732351327; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qD/PSgFlehOn9QqoTVH1cb+ziNhJJDu+AfRYpR73DRc=;
        b=fnp5MNNBeZlEBGT4okzceHAHw1Wiefn2JbaOXqUQ3YZQn9fUYbxYWGfYsJ/BwyEL+S
         B0ChcTKyQzs4LAXFxi92i91UjGHlToWRH/7Ul23g5VReE1c1CJc+awhld2nts7G9vKAN
         1B4jG1ihYyy+DpRboD0U1i66OwaV5XWiPZkJMh5GtPG7aMxVul5RUX4KG25RcRE3Dqwv
         j73T7HtJbff5Zv8jtQICFA7P7jcBAlHK4zCYT1mlGw9oZoX5HFVHJT0dsgpnC4Gd7ut5
         STL+40dxt/xDdhc61WOGc5+tJIwW3jBZIvdL6t8ZsFjdG5bFImm0yJM/MLmKqFT+zmTD
         gAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731746527; x=1732351327;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qD/PSgFlehOn9QqoTVH1cb+ziNhJJDu+AfRYpR73DRc=;
        b=W2YlsXSTu/7MxkM7IDHD1WH8YYdDaoG518a7myzSMIfZYL1WWKfygJnuPFgWN1zunr
         innGlFWoee/B1AwVDHCeszvw3ffvD1tpSxCeCh1iosbcElqDdQ8WAYbc3g3EreA7gaaS
         dmsZ6+YWs+x4asP+q6WQRF41YaWK1vR7tJYeJcNscOUh4sLDIWuKAAkJq5yIBzS9KTI0
         PSrGea4xSSig4PQLw5+9anYUHYoRsFs2U7DQd5GjFEzeE7ZWKORCzpNyZgVmm3zb/DlY
         4l3SeHXbGEy5YJ5sBqJBV/m/EyRnsCfHKP0xpWojhc0yNseU9BQCCsh50zUfDgvNEwih
         /V4g==
X-Gm-Message-State: AOJu0YzsbSaBT3Y7HzbMkYBAyUwC09+iizdcV3zZ0P5iRAeSBC9kDHv0
	7CirST1SuNZNLM5m1Jzbl0G15YARuQLaDMBgfwuuxhyzMz+AImFUoRm1q7gpfRt4LmejX0fUuf/
	b
X-Google-Smtp-Source: AGHT+IG1oFCmhu6ZkIFfziXfj2Y9E7CtL16NrnXKqy0a+kbhGk9ZtfR762BdiRMU0kvKoGoLnQwckw==
X-Received: by 2002:a05:6000:1445:b0:382:22d5:9e55 with SMTP id ffacd0b85a97d-38225a883b3mr3417877f8f.42.1731746526922;
        Sat, 16 Nov 2024 00:42:06 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ae1685csm6782443f8f.83.2024.11.16.00.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 00:42:06 -0800 (PST)
Date: Sat, 16 Nov 2024 11:42:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [bug report] statmount: retrieve security mount options
Message-ID: <c8eaa647-5d67-49b6-9401-705afcb7e4d7@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Christian Brauner,

Commit aefff51e1c29 ("statmount: retrieve security mount options")
from Nov 14, 2024 (linux-next), leads to the following Smatch static
checker warning:

	fs/namespace.c:5120 statmount_opt_sec_array()
	info: return a literal instead of 'err'

fs/namespace.c
    5108 static int statmount_opt_sec_array(struct kstatmount *s, struct seq_file *seq)
    5109 {
    5110         struct vfsmount *mnt = s->mnt;
    5111         struct super_block *sb = mnt->mnt_sb;
    5112         size_t start = seq->count;
    5113         char *buf_start;
    5114         int err;
    5115 
    5116         buf_start = seq->buf + start;
    5117 
    5118         err = security_sb_show_options(seq, sb);
    5119         if (!err)
                     ^^^^
--> 5120                 return err;

The Smatch check is suggesting that the return statement should be "return 0;"
but I'm not totally sure.  It sort of looks like this if statement is reversed.

    5121 
    5122         if (unlikely(seq_has_overflowed(seq)))
    5123                 return -EAGAIN;
    5124 
    5125         if (seq->count == start)
    5126                 return 0;
    5127 
    5128         err = statmount_opt_unescape(seq, buf_start);
    5129         if (err < 0)
    5130                 return err;
    5131 
    5132         s->sm.opt_sec_num = err;
    5133         return 0;
    5134 }

regards,
dan carpenter

