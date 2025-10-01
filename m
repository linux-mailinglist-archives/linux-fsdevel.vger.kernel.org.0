Return-Path: <linux-fsdevel+bounces-63194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0289ABB141D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 18:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D02E17A8919
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 16:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1002628643B;
	Wed,  1 Oct 2025 16:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="h3P0dW5a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D121242056
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Oct 2025 16:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759336462; cv=none; b=Jm6P4u/+p9PYSipMxaHO0h0YI0AKzcvWJJkd1GM0L/++lDatLxe/n2CbTIby8X5TKUGqclVLCBuGntn4z7IhMjc5uzMJwVvH2RrLvSzKGgJjLziVAMws9JD4u/ayCwPXQLnvYSvMBwUh0RjmQYo+I4Tvp7ewD799UqTTA+2tiqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759336462; c=relaxed/simple;
	bh=5+QqJQbHRRoYFJP7mLVXHvJ98veWuboSrwuUjqJ3OeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IMUr44pwHkqSy9dn4IOhJvg1BE/t9JB1sMlpTHBqPjYLukKQ1KEepS9pjwuzJ61NwAlqPAYA7fPadcRZDuGL5wqBKJjNsjm2t85VVObuE9Zyvi99ILCvxVIwOY8iCxVFqJYmh6VIqoRQ6q0JH3eTktVMeeYNOy3IZnm9Iw0nHKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=h3P0dW5a; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-85d5cd6fe9fso5648485a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Oct 2025 09:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1759336460; x=1759941260; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g3OHJw2rFgayx5kHjxMIlmwKKQXiU3P7o73X7At+/J4=;
        b=h3P0dW5al8AcP135cZZgs/DUtK/4IHw5W9om0pCzJKg5cTkahmq7HNiD0DE8yB/oS+
         yR1pe0qdZhIy5XIt10nRwbSX6GhAvLmElNRM97GIrOOV9LFz+eXsCE5wlKrx4WULFdco
         NTvJBLSHhdrenSURv3NZIPfJdyQRx/XRpILYH+z21LkEfzKS0XEg4n2nl/YKVF7WDjjQ
         h+UeYoNWwppZMo9KtXOxoeGFvU1kT78pg+k8snaCz8uAF0kvD4y11+fsdP2tGf9NNJBU
         Sz6UeV05LLY9F6ieuoNz+hLhzwcJCrJfBcoFBSg6QQhEndLJMhVKOzxP0QtxUCLSRO1E
         y43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759336460; x=1759941260;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g3OHJw2rFgayx5kHjxMIlmwKKQXiU3P7o73X7At+/J4=;
        b=Szl/0pFwvxKA2HEcAVb3bVOiVJjQrD7Zieki1vTHzAbeLgoCq8SzxQywVmen88jXvu
         oE6uJMxvEB0oNCKOzT9xqH2BdI1Fe3XVO19zv0fXbmJeHgkjA2TUmYJUgOE3vFHGNB8Y
         BBvKnmp0gN6CamNIqIUPjyMJwuIfeLV0P2gLq+YSCOkg2WpysnYTubHtOxZaAEJzvtF2
         Qd9kUBEGDKi/5YJsk66go4vUtiiVM+lLTxrVMm6P+kfbJGpix9R4owVJgyHit28pSgeM
         3roAbeqbKQTVTp0vmtKA1xcoHwN8KKjg+TzkVNMLsS9SqE9rvPwO7Tbi2YS3CDQQnUNm
         mRRw==
X-Gm-Message-State: AOJu0Yz5bQ+72eT37w2ZvcbmIgd9/6IPAGt1myf+U1adBqz3wSJW24lo
	rqbM4BJuLISE72v7AtTUravaR+z88qfpbMeOxUSNcpFlXEfrZRR9eXfv4heX6CDaTZE=
X-Gm-Gg: ASbGncuA+KoCtn67ozSgILnPESnzuhuaKht4yZQSSj3R0uVgSpM7ZTn5Fh8ZYVn8tQN
	TmGiCPqIhMECnHHaktLFucDySWe+3XlsU2y+RB+PZ8XpHMYATUIyRLYJWWHP1KZkCEztOoekcQ+
	kk5ta1uE/pZwm9REaZWdGk9wQqDdKfGHA7iyboQbWKI7JwBwhmhgYYjDec2QpZh320qgm6/DJPn
	qyzPPXxHmbNVBAG3YSJO3uDGu8Nrj8TQ7g4dg9ewV/A9Wb/7kKzWvyimoJzKAQ10erk1tIcwEs8
	J6CXd1FhNkm+wQ7WwIfLXY1qvcnEIwVXXFVBSssmMI0p6EkjmtEbpwWofnzx1zjjj9oP0i1EKme
	y6oQteUDtekTd6BMWl5lvkrhHd3n7FKHBqhYbkMeLBJBEGkYZIoshiAzIp+8=
X-Google-Smtp-Source: AGHT+IG7mfdSIVF3b6xWViAv4VKI/WY1cdPmIB6tNLMxyt7NIxTMEwyV5GEywZ7bf4CfOh0oMEVWFQ==
X-Received: by 2002:a05:620a:4505:b0:870:4652:4d19 with SMTP id af79cd13be357-873720c1d59mr598377085a.28.1759336459079;
        Wed, 01 Oct 2025 09:34:19 -0700 (PDT)
Received: from [172.24.25.128] ([65.222.209.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-87772836c1csm8359185a.28.2025.10.01.09.34.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 09:34:18 -0700 (PDT)
Message-ID: <408ad037-639a-4051-831b-b663c0d2d772@zetier.com>
Date: Wed, 1 Oct 2025 12:34:16 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/1] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "cpgs@samsung.com" <cpgs@samsung.com>,
 "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
 "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
References: <20250912032619.9846-1-ethan.ferguson@zetier.com>
 <20250912032619.9846-2-ethan.ferguson@zetier.com>
 <PUZPR04MB6316E73EE47154A64F8733DA8118A@PUZPR04MB6316.apcprd04.prod.outlook.com>
Content-Language: en-US
From: Ethan Ferguson <ethan.ferguson@zetier.com>
In-Reply-To: <PUZPR04MB6316E73EE47154A64F8733DA8118A@PUZPR04MB6316.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/28/25 06:28, Yuezhang.Mo@sony.com wrote:
> On Fri, Sep 12, 2025 11:26 Ethan Ferguson <ethan.ferguson@zetier.com> wrote:
>> +int exfat_read_volume_label(struct super_block *sb, struct exfat_uni_name *label_out)
>> +{
>> +       int ret, i;
>> +       struct exfat_sb_info *sbi = EXFAT_SB(sb);
>> +       struct exfat_entry_set_cache es;
>> +       struct exfat_dentry *ep;
>> +
>> +       mutex_lock(&sbi->s_lock);
>> +
>> +       memset(label_out, 0, sizeof(*label_out));
>> +       ret = exfat_get_volume_label_dentry(sb, &es);
>> +       if (ret < 0) {
>> +               /*
>> +                * ENOENT signifies that a volume label dentry doesn't exist
>> +                * We will treat this as an empty volume label and not fail.
>> +                */
>> +               if (ret == -ENOENT)
>> +                       ret = 0;
>> +
>> +               goto unlock;
>> +       }
>> +
>> +       ep = exfat_get_dentry_cached(&es, 0);
>> +       label_out->name_len = ep->dentry.volume_label.char_count;
>> +       if (label_out->name_len > EXFAT_VOLUME_LABEL_LEN) {
>> +               ret = -EIO;
>> +               goto unlock;
>> +       }
>> +
>> +       for (i = 0; i < label_out->name_len; i++)
>> +               label_out->name[i] = le16_to_cpu(ep->dentry.volume_label.volume_label[i]);
>> +
>> +unlock:
>> +       mutex_unlock(&sbi->s_lock);
>> +       return ret;
>> +}
> 
> Hi Ethan Ferguson,
> 
> This function has a buffer leak due to a missed call to
> exfat_put_dentry_set(). Please fix it.
> 
> Thanks
Apologies that I missed that, I would be more than happy to submit a fixed patch for this,
but I checked the dev branch of the exfat tree and noticed some lines were added to fix this
problem in my commit. If true, this is fine by me, and I will sign off on it, but I just
want to make sure that's true, because if so then I don't think another patch by me is needed.

Thank you!

