Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CED9897A79
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 15:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbfHUNPR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 09:15:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbfHUNPR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 09:15:17 -0400
Received: from [192.168.0.101] (unknown [180.111.132.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CC2B214DA;
        Wed, 21 Aug 2019 13:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566393316;
        bh=EO9Bip6DSF9x/AWrsU50iQqY5CV6rf7s8XCVw7bhH/k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=C3segr/6YdtzYrAkfoIuaHjBH3hsXn3HQvP3H7GYJ/LLFZRYBIIIVVUZtmNmVhUes
         SQL67+adFwRxD/HgPcOsaqyJ0V1E7R04rt0k0RuHtHUbHfGfjeaOLhvl9EEyLTddQa
         PwteJ65+4VijcgcfVc0cubkDO43wTJ1A/F01XGUU=
Subject: Re: [f2fs-dev] [PATCH v4 3/3] f2fs: Support case-insensitive file
 name lookups
To:     Daniel Rosenberg <drosen@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-doc@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@android.com
References: <20190723230529.251659-1-drosen@google.com>
 <20190723230529.251659-4-drosen@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <354102fb-e076-78d4-174d-5a193cae70f0@kernel.org>
Date:   Wed, 21 Aug 2019 21:15:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190723230529.251659-4-drosen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-7-24 7:05, Daniel Rosenberg via Linux-f2fs-devel wrote:
> +static int f2fs_d_compare(const struct dentry *dentry, unsigned int len,
> + const char *str, const struct qstr *name)
> +{
> +	struct qstr qstr = {.name = str, .len = len };
> +
> +	if (!IS_CASEFOLDED(dentry->d_parent->d_inode)) {
> +		if (len != name->len)
> +			return -1;
> +		return memcmp(str, name, len);

66883da1eee8 ("ext4: fix dcache lookup of !casefolded directories")

memcmp(str, name->name, len);
