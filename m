Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4173434DE1D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 04:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbhC3CR2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Mar 2021 22:17:28 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58244 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbhC3CRG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Mar 2021 22:17:06 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 3A9B61F451A2
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org, chao@kernel.org,
        drosen@google.com, yuchao0@huawei.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com,
        andre.almeida@collabora.com
Subject: Re: [PATCH v5 4/4] fs: unicode: Add utf8 module and a unicode layer
Organization: Collabora
References: <20210329204240.359184-1-shreeya.patel@collabora.com>
        <20210329204240.359184-5-shreeya.patel@collabora.com>
        <YGKGhxaozX3ND6iB@gmail.com>
Date:   Mon, 29 Mar 2021 22:16:57 -0400
In-Reply-To: <YGKGhxaozX3ND6iB@gmail.com> (Eric Biggers's message of "Mon, 29
        Mar 2021 19:01:43 -0700")
Message-ID: <87v999pequ.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> writes:

> On Tue, Mar 30, 2021 at 02:12:40AM +0530, Shreeya Patel wrote:
>> diff --git a/fs/unicode/Kconfig b/fs/unicode/Kconfig
>> index 2c27b9a5cd6c..ad4b837f2eb2 100644
>> --- a/fs/unicode/Kconfig
>> +++ b/fs/unicode/Kconfig
>> @@ -2,13 +2,26 @@
>>  #
>>  # UTF-8 normalization
>>  #
>> +# CONFIG_UNICODE will be automatically enabled if CONFIG_UNICODE_UTF8
>> +# is enabled. This config option adds the unicode subsystem layer which loads
>> +# the UTF-8 module whenever any filesystem needs it.
>>  config UNICODE
>> -	bool "UTF-8 normalization and casefolding support"
>> +	bool
>> +
>> +# utf8data.h_shipped has a large database table which is an auto-generated
>> +# decodification trie for the unicode normalization functions and it is not
>> +# necessary to carry this large table in the kernel.
>> +# Enabling UNICODE_UTF8 option will allow UTF-8 encoding to be built as a
>> +# module and this module will be loaded by the unicode subsystem layer only
>> +# when any filesystem needs it.
>> +config UNICODE_UTF8
>> +	tristate "UTF-8 module"
>>  	help
>>  	  Say Y here to enable UTF-8 NFD normalization and NFD+CF casefolding
>>  	  support.
>> +	select UNICODE
>
> This seems problematic; it allows users to set CONFIG_EXT4_FS=y (or
> CONFIG_F2FS_FS=y) but then CONFIG_UNICODE_UTF8=m.  Then the filesystem won't
> work if the modules are located on the filesystem itself.

Hi Eric,

Isn't this a user problem?  If the modules required to boot are on the
filesystem itself, you are in trouble.  But, if that is the case, your
rootfs is case-insensitive and you gotta have utf8 as built-in or have
it in an early userspace.

> I think it should work analogously to CONFIG_FS_ENCRYPTION and
> CONFIG_FS_ENCRYPTION_ALGS.  That is, CONFIG_UNICODE should be a user-selectable
> bool, and then the tristate symbols CONFIG_EXT4_FS and CONFIG_F2FS_FS should
> select the tristate symbol CONFIG_UNICODE_UTF8 if CONFIG_UNICODE.





-- 
Gabriel Krisman Bertazi
