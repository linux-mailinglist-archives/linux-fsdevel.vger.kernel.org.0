Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AFC5F71D5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 01:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbiJFXfq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 19:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbiJFXfn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 19:35:43 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711A5CD5D0;
        Thu,  6 Oct 2022 16:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lhumk7loW+962AX8hCR6F46wrrP6cqHeoz6oa2OTOgg=; b=ad5c8QOxs2lMH8kVtuyYZJuzDS
        nTyJaJ7eg80mUv+CymZPJ6Aj+cjb84t6D8kFjd6lOX5pQxHeah614bgQG4ejvj9kEK5UcdiSIOkt3
        Vja+nCHb4FghEJMNt8OAI7lKAdrrJPNv3Mbrle+XIqiTw1H6bR6Zpxk1sTs86qwPFBO3SaoZEZE6K
        V5mngGTdQXfEZXA4ITuBQxlIyw4pKP97r8uc1AIHJtVempgiC/z78pY5wWO2EJzu3nKQUlZDl+zFH
        iVGamMlm9IfZ0HqVxm0BE/qESVN7o7b+E0Usj6Sf7YlONDMvgGTZNiucMgND8siVbGxhHvW1z/qdm
        td+BivRQ==;
Received: from 201-43-120-40.dsl.telesp.net.br ([201.43.120.40] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1ogaOy-00C7OK-Ez; Fri, 07 Oct 2022 01:35:40 +0200
Message-ID: <d0fb08ca-872e-1b46-9c6c-4896fdaebb0a@igalia.com>
Date:   Thu, 6 Oct 2022 20:35:27 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/8] pstore: Improve error reporting in case of backend
 overlap
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com
References: <20221006224212.569555-1-gpiccoli@igalia.com>
 <20221006224212.569555-2-gpiccoli@igalia.com>
 <202210061627.E29FCDBE1@keescook>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <202210061627.E29FCDBE1@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 06/10/2022 20:27, Kees Cook wrote:
> On Thu, Oct 06, 2022 at 07:42:05PM -0300, Guilherme G. Piccoli wrote:
>> The pstore infrastructure supports one single backend at a time;
>> trying to load a another backend causes an error and displays a
>> message, introduced on commit 0d7cd09a3dbb ("pstore: Improve
>> register_pstore() error reporting").
>>
>> Happens that this message is not really clear about the situation,
>> also the current error returned (-EPERM) isn't accurate, whereas
>> -EBUSY makes more sense. We have another place in the code that
>> relies in the -EBUSY return for a similar check.
>>
>> So, make it consistent here by returning -EBUSY and using a
>> similar message in both scenarios.
>>
>> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
>> ---
>>  fs/pstore/platform.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
>> index 0c034ea39954..c32957e4b256 100644
>> --- a/fs/pstore/platform.c
>> +++ b/fs/pstore/platform.c
>> @@ -562,8 +562,9 @@ static int pstore_write_user_compat(struct pstore_record *record,
>>  int pstore_register(struct pstore_info *psi)
>>  {
>>  	if (backend && strcmp(backend, psi->name)) {
>> -		pr_warn("ignoring unexpected backend '%s'\n", psi->name);
>> -		return -EPERM;
>> +		pr_warn("backend '%s' already in use: ignoring '%s'\n",
>> +			backend, psi->name);
>> +		return -EBUSY;
> 
> Thank you! Yes, this has bothered me for a while. :)

Heheh ditto! Thank you for the great and fast review =)
