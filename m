Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAAF34829B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 21:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238178AbhCXUKS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 16:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238174AbhCXUJ6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 16:09:58 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F01C061763;
        Wed, 24 Mar 2021 13:09:58 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 8EEA71F45E6A
Subject: Re: [RFC PATCH 1/4] Revert "libfs: unexport generic_ci_d_compare()
 and generic_ci_d_hash()"
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        krisman@collabora.com, smcv@collabora.com, kernel@collabora.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Rosenberg <drosen@google.com>
References: <20210323195941.69720-1-andrealmeid@collabora.com>
 <20210323195941.69720-2-andrealmeid@collabora.com>
 <20210323201530.GL1719932@casper.infradead.org>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <5c20d261-eef2-aecc-8f1e-58fb5dbfcd72@collabora.com>
Date:   Wed, 24 Mar 2021 17:09:48 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210323201530.GL1719932@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew,

Às 17:15 de 23/03/21, Matthew Wilcox escreveu:
> On Tue, Mar 23, 2021 at 04:59:38PM -0300, André Almeida wrote:
>> This reverts commit 794c43f716845e2d48ce195ed5c4179a4e05ce5f.
>>
>> For implementing casefolding support at tmpfs, it needs to set dentry
>> operations at superblock level, given that tmpfs has no support for
>> fscrypt and we don't need to set operations on a per-dentry basis.
>> Revert this commit so we can access those exported function from tmpfs
>> code.
> 
> But tmpfs / shmem are Kconfig bools, not tristate.  They can't be built
> as modules, so there's no need to export the symbols.
> 
>> +#ifdef CONFIG_UNICODE
>> +extern int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str);
>> +extern int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
>> +				const char *str, const struct qstr *name);
>> +#endif
> 
> There's no need for the ifdef (it only causes unnecessary rebuilds) and
> the 'extern' keyword is also unwelcome.
> 

Thank you. Instead of reverting the commit, I'll do a new commit doing 
this in a properly way.
