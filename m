Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA613573B6C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 18:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236945AbiGMQmF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 12:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiGMQmE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:42:04 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D76A2E9CD;
        Wed, 13 Jul 2022 09:42:01 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id C9AA11DDC;
        Wed, 13 Jul 2022 16:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1657730451;
        bh=L/FOpnrzMfL9B4xoXMpZpviC2zK+4A0KAaRqNTQmhZY=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=fD/wiLtpHdPi5zklceAp1jL5Mdan5I/wPBuF4X5m0qk/aRwMcrt9SL0RmpdiWkB5Y
         sQXSjMNJPSSKEP4JFbH0mvr2T67fVcnAvOOj/g2MtVa9UTUPq5zgu4agc+IrXbm1MV
         iWyDV0Mhk6Db2Tx0a24eaz9jki3Kw40yqlyA70rI=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 5099D213E;
        Wed, 13 Jul 2022 16:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1657730519;
        bh=L/FOpnrzMfL9B4xoXMpZpviC2zK+4A0KAaRqNTQmhZY=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=eEMc0T/Bw1CYM3EeINAdCe65oV6fPVNd4LlvXw+2uyoOaPpNIKkxs7Cq7Hxe++Ea2
         XnmHXA28v4SDkSfLRg60o7YOPbBmWqKUJxMsY/FlmV0cxIvpS5tL39cNObQcSfP7Lr
         jCwYhyh09adxkQzpD7o6KH3Ypw2S+Ex+1AP09mlM=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 13 Jul 2022 19:41:58 +0300
Message-ID: <c8b65567-6a4d-2e61-b2a0-3a757ae9b36c@paragon-software.com>
Date:   Wed, 13 Jul 2022 19:41:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/2] fs/ntfs3: Refactoring and improving logic in run_pack
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
CC:     <ntfs3@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <d578fcbe-e1f7-ffc7-2535-52eecb271a01@paragon-software.com>
 <YsZkQAsKC6qxY8gi@infradead.org>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <YsZkQAsKC6qxY8gi@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/7/22 07:42, Christoph Hellwig wrote:
> Hi Konstantin,
> 
> now that you have time to actively work on the ntfs3 driver again, can
> you consider looking into converting the I/O path to iomap, as already
> request during the merge?  Getting drivers off the old buffer head based
> I/O helpers is something we need to address in the coming years, so
> any relatively simple and actually maintained file system would be a
> good start.
> 
> On Wed, Jul 06, 2022 at 08:31:25PM +0300, Konstantin Komarov wrote:
>> 2 patches:
>> - some comments and making function static;
>> - improving speed of run_pack by checking runs in advance
>>
>> Konstantin Komarov (2):
>>    fs/ntfs3: Added comments to frecord functions
>>    fs/ntfs3: Check possible errors in run_pack in advance
>>
>>   fs/ntfs3/bitmap.c  |  3 +--
>>   fs/ntfs3/frecord.c |  8 ++++----
>>   fs/ntfs3/ntfs_fs.h |  1 -
>>   fs/ntfs3/run.c     | 41 +++++++++++++++++++++++------------------
>>   4 files changed, 28 insertions(+), 25 deletions(-)
>>
>> -- 
>> 2.37.0
>>
> ---end quoted text---

Hi Christoph

I will look into converting the I/O path to iomap.
Thank you for reminding about it.
