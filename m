Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 601E9113CA5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 08:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbfLEH41 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 02:56:27 -0500
Received: from mail.loongson.cn ([114.242.206.163]:49826 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725963AbfLEH41 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 02:56:27 -0500
Received: from [10.130.0.36] (unknown [123.138.236.242])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxTxQGuOhdmTgHAA--.9S3;
        Thu, 05 Dec 2019 15:55:59 +0800 (CST)
Subject: Re: [PATCH v2] fs: introduce is_dot_dotdot helper for cleanup
To:     Matthew Wilcox <willy@infradead.org>
References: <1575377810-3574-1-git-send-email-yangtiezhu@loongson.cn>
 <20191203135651.GU20752@bombadil.infradead.org>
 <0003a252-b003-0a8c-b4ac-6280557ece06@loongson.cn>
 <20191205070646.GA29612@bombadil.infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Tyler Hicks <tyhicks@canonical.com>,
        linux-fsdevel@vger.kernel.org, ecryptfs@vger.kernel.org,
        linux-fscrypt@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <b3f23eef-3799-6ddd-43ba-11a90f49279d@loongson.cn>
Date:   Thu, 5 Dec 2019 15:55:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20191205070646.GA29612@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9DxTxQGuOhdmTgHAA--.9S3
X-Coremail-Antispam: 1UD129KBjvdXoW7XFyfJr4fAFWDJry7Cr4fGrg_yoW3Wrc_uw
        4kWrZ7Aws8tFZ09Fs8Ga1FqrZxKaya9rykJrn3t3Wjy345X39xCrWDCrn5Wwn3Ga1xJrsI
        qrWavrn8JwnagjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbT8YjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
        Mxk0xIA0c2IEe2xFo4CEbIxvr21lc2xSY4AK67AK6r4xMxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
        j40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
        4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUc3xhDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/05/2019 03:06 PM, Matthew Wilcox wrote:
> On Thu, Dec 05, 2019 at 08:56:07AM +0800, Tiezhu Yang wrote:
>>> And, as I asked twice in the last round of review, did you benchmark
>>> this change?
>> Before sending this v2 patch, I have done the test used with your test
>> program and already pointed out the following implementation is better:
> I didn't mean "have you run the test program i wrote".  I meant "have you
> booted a kernel with this change and done some performance measurements
> to see if you've changed anything".

Oh, no, it is hard to measure the performance influence with this patch.
Based on the above analysis, I think the performance influence is very
small due to is_dot_dotdot() is a such short static inline function.

Thanks,

Tiezhu Yang

