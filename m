Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586DB245E86
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Aug 2020 09:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgHQHwv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 03:52:51 -0400
Received: from verein.lst.de ([213.95.11.211]:55503 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbgHQHwu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:52:50 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0E90E68AFE; Mon, 17 Aug 2020 09:52:46 +0200 (CEST)
Date:   Mon, 17 Aug 2020 09:52:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] test_bitmap: skip user bitmap tests for
 !CONFIG_SET_FS
Message-ID: <20200817075245.GA15391@lst.de>
References: <20200817073212.830069-1-hch@lst.de> <20200817073212.830069-6-hch@lst.de> <9e632937-9e9a-faed-bc0e-fcb7a6b4f54c@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e632937-9e9a-faed-bc0e-fcb7a6b4f54c@csgroup.eu>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 17, 2020 at 09:50:05AM +0200, Christophe Leroy wrote:
>
>
> Le 17/08/2020 à 09:32, Christoph Hellwig a écrit :
>> We can't run the tests for userspace bitmap parsing if set_fs() doesn't
>> exist.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>   lib/test_bitmap.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
>> index df903c53952bb9..49b1d25fbaf546 100644
>> --- a/lib/test_bitmap.c
>> +++ b/lib/test_bitmap.c
>> @@ -365,6 +365,7 @@ static void __init __test_bitmap_parselist(int is_user)
>>   	for (i = 0; i < ARRAY_SIZE(parselist_tests); i++) {
>>   #define ptest parselist_tests[i]
>>   +#ifdef CONFIG_SET_FS
>
> get_fs() and set_fs() have stubs for when an arch doesn't define them, so I 
> this it would be cleaner if you were using 'if (IS_ENABLED(CONFIG_SET_FS) 
> && is_user)`instead of an ifdefery in the middle of the if/else.

No, I don't provide stubs in the prep patch, and that has been intentional
as I don't want this to spread much.  test_bitmap would be the only place
where they are somewht useful, and I just hope this test is eventually
getting rewritten to run in a normal user space context where the
uaccess tests can be resurrected.
