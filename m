Return-Path: <linux-fsdevel+bounces-4827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CAF804897
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 05:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28A2B281418
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 04:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C9E6AC0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 04:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkkdiYj9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422196FB1
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Dec 2023 03:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D43C433CB
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Dec 2023 03:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701747018;
	bh=mJoL21UN9FSjQdDu6xoq6OV3LrvQUv/OQAguiGR2ddw=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=nkkdiYj9BqSVWsQfWg+CE7J7YM5UWC4YjuHrE7/nKt7hd4t6S7aT1ZQweVzBc5ym4
	 XHsZOBjOXvRcJCQu3D7DwrDJpOLt+EFqfcjM5C8B2AvUIsC8QvVnucriu/Z9jeGisK
	 sBtFn4RzkJEr6MGXbYRECVpa+eeulsHmJ/Luxjrf4/1xUA0dfX0a2/pbzzfajpaUal
	 F2k6T9aO6QZDZTMf1HREPC6E4MAl67+wrLQv6HarIFeXQ74NnHWicsglpQihnNTula
	 WQ4CKMZFGasqn4MGAw5pzRi1TU0Zskn7TJryUzMZLIXEoFDT9izaqVuPo6h/w55bE2
	 7G/VAt/wL496Q==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1faea6773c9so2949393fac.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Dec 2023 19:30:17 -0800 (PST)
X-Gm-Message-State: AOJu0YyTB9HiK38zeX/RvXOMbqX4GY4mrwsvNOXIxAJrNf0WSRgx6BZ1
	0K+oCyxP4oOMRxCiGI49EGcXCyZljVDw1ng6oDo=
X-Google-Smtp-Source: AGHT+IFgVC1PWTeCjR7Q48rYla4hVKQLLE9NqdIAyq0WpijgqwqohaJqxZwlL4xrfYarc352K67X+pUvVNDi/qR+A1I=
X-Received: by 2002:a05:6870:a10e:b0:1fb:64:1b25 with SMTP id
 m14-20020a056870a10e00b001fb00641b25mr6091164oae.24.1701747017207; Mon, 04
 Dec 2023 19:30:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ac9:5a85:0:b0:507:5de0:116e with HTTP; Mon, 4 Dec 2023
 19:30:16 -0800 (PST)
In-Reply-To: <PUZPR04MB6316F0640983B00CC55D903F8182A@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <PUZPR04MB6316D39C9404C34756CA368981A6A@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <PUZPR04MB6316F0640983B00CC55D903F8182A@PUZPR04MB6316.apcprd04.prod.outlook.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 5 Dec 2023 12:30:16 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_VDotfcAHq+4TjM6oEdb7fO-QOuO8sAftNvZGed7o_cA@mail.gmail.com>
Message-ID: <CAKYAXd_VDotfcAHq+4TjM6oEdb7fO-QOuO8sAftNvZGed7o_cA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] exfat: change to get file size from DataLength
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "Andy.Wu@sony.com" <Andy.Wu@sony.com>, 
	"Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>, "cpgs@samsung.com" <cpgs@samsung.com>
Content-Type: text/plain; charset="UTF-8"

> +static int exfat_file_zeroed_range(struct file *file, loff_t start, loff_t
> end)
> +{
> +	int err;
> +	struct inode *inode = file_inode(file);
> +	struct exfat_inode_info *ei = EXFAT_I(inode);
> +	struct address_space *mapping = inode->i_mapping;
> +	const struct address_space_operations *ops = mapping->a_ops;
> +
> +	while (start < end) {
> +		u32 zerofrom, len;
> +		struct page *page = NULL;
> +
> +		zerofrom = start & (PAGE_SIZE - 1);
> +		len = PAGE_SIZE - zerofrom;
> +		if (start + len > end)
> +			len = end - start;
> +
> +		err = ops->write_begin(file, mapping, start, len, &page, NULL);
Is there any reason why you don't use block_write_begin and
generic_write_end() ?

Thanks.
> +		if (err)
> +			goto out;
> +
> +		zero_user_segment(page, zerofrom, zerofrom + len);
> +
> +		err = ops->write_end(file, mapping, start, len, len, page, NULL);
> +		if (err < 0)
> +			goto out;
> +		start += len;
> +
> +		balance_dirty_pages_ratelimited(mapping);
> +		cond_resched();
> +	}
> +
> +	ei->valid_size = end;
> +	mark_inode_dirty(inode);
> +
> +out:
> +	return err;
> +}

