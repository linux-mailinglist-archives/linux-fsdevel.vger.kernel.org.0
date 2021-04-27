Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A3636C255
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 12:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbhD0KKI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 06:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235133AbhD0KKI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 06:10:08 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D84CC061574;
        Tue, 27 Apr 2021 03:09:25 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: shreeya)
        with ESMTPSA id AA8EE1F425CB
Subject: Re: [PATCH v8 4/4] fs: unicode: Add utf8 module and a unicode layer
To:     Christoph Hellwig <hch@infradead.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        chao@kernel.org, krisman@collabora.com, ebiggers@google.com,
        drosen@google.com, ebiggers@kernel.org, yuchao0@huawei.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com,
        andre.almeida@collabora.com
References: <20210423205136.1015456-1-shreeya.patel@collabora.com>
 <20210423205136.1015456-5-shreeya.patel@collabora.com>
 <20210427062907.GA1564326@infradead.org>
From:   Shreeya Patel <shreeya.patel@collabora.com>
Message-ID: <61d85255-d23e-7016-7fb5-7ab0a6b4b39f@collabora.com>
Date:   Tue, 27 Apr 2021 15:39:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210427062907.GA1564326@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 27/04/21 11:59 am, Christoph Hellwig wrote:
> On Sat, Apr 24, 2021 at 02:21:36AM +0530, Shreeya Patel wrote:
>> utf8data.h_shipped has a large database table which is an auto-generated
>> decodification trie for the unicode normalization functions.
>> We can avoid carrying this large table in the kernel unless it is required
>> by the filesystem during boot process.
>>
>> Hence, make UTF-8 encoding loadable by converting it into a module and
>> also add built-in UTF-8 support option for compiling it into the
>> kernel whenever required by the filesystem.
> The way this is implemement looks rather awkward.
>
> Given that the large memory usage is for a data table and not for code,
> why not treat is as a firmware blob and load it using request_firmware?


utf8 module not just has the data table but also has some kernel code.
The big part that we are trying to keep out of the kernel is a tree 
structure that gets traversed based on a key that is the file name.
This is done when issuing a lookup in the filesystem, which has to be 
very fast. So maybe it would not be so good to use request_firmware for
such a core feature.
