Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DAA4D6D03
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Mar 2022 07:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiCLGcB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Mar 2022 01:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiCLGcA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Mar 2022 01:32:00 -0500
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E866622321B
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Mar 2022 22:30:54 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id D625D120A0B;
        Sat, 12 Mar 2022 06:23:12 +0000 (UTC)
Received: from pdx1-sub0-mail-a285.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 4202B120917;
        Sat, 12 Mar 2022 06:23:12 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1647066192; a=rsa-sha256;
        cv=none;
        b=o3RnW6CW664n9zExlcBuqo54yHAkZUss8PuQZ5wJ5TkxLuRkR/hQLZfU8uweKD4dL3MGhP
        CFnFYwrscnvCFglGHJYM4pLpFtR/wZ0ds1qqsHrog+GypiGk232RZFcv6BtcCt7AZVBnpK
        p2M1x13+MoPC6DFy2+7E/P/d4mqUdq2MIK/mZDySFdmT0lZpA7L7gY/DbCLhAt5Zs9ClcF
        g8YHWUjlWg3dKnHDL1IRJU3SzvxnpVA3RySqQX9Wq/VHzCm0t5RzJqMllPBpSymIYLOsfA
        3FmYYJZ0IJHoXEb+gAZLG7nX0Z8DZGpVP2uREdTvz65X4elvtvx7uFz3KVWKUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1647066192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=ZT6VYtL+vw9T6Ub1vZFvKzNpePpg6HvywdN/5J0ms3A=;
        b=KG/AGyrqjGG56k+ROYlE8sRPDAPbaF9wE6e6nysfp8ilOxa6wHBjvsft8+agHs5P2vGolx
        cqfFGrLcdrp8cqGG75JZs/MB8mKn1RbaYCKBZU58JjqKPU/eLbiJbtt3zJHnFcC/liGb3c
        uSNoXwhhZ6Z8VZcml7m38+nqntMElFxDbN/UFaeVi1TIAMUEIcpXSUisZ7MsG++zRa68SM
        26xf2xT/jNofYgYjbXjVYlr6WdqYP7ERC/Y2OvI3yj3n/nuQ7cVLOnpu8aX9FdktxSxvMx
        kYDqOkzcLFtM/Ee3uYaP3envgaBNPR88LnuVKlQ3cWhmoXeXLdXlaZ0C37SOoQ==
ARC-Authentication-Results: i=1;
        rspamd-74bfb75fc6-7fwp9;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a285.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.121.210.153 (trex/6.5.3);
        Sat, 12 Mar 2022 06:23:12 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Ruddy-Hysterical: 4f10bc886adb8da1_1647066192610_2593148567
X-MC-Loop-Signature: 1647066192610:1373089155
X-MC-Ingress-Time: 1647066192609
Received: from offworld (unknown [104.36.25.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a285.dreamhost.com (Postfix) with ESMTPSA id 4KFt5q2Knrz2D;
        Fri, 11 Mar 2022 22:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1647066192;
        bh=t8Z4mZVXuCsWQ9U69iGvsRsjxPW8BY5M80Cl7ufLOQw=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=NRvqJfHoXh3CqdhILWYE1/0nVWER03Xp3QGPB7z3APIYb3SuCbwPikhqtqq3ln5Ei
         PTEgQYnCol0+rmUNPmD1d7WjVczdFRK1WGZJ9xrXXBm63xn8zYgHjBIaDojOcX6+np
         758+wIMM2QCToxANG6QRVzAdUx7pBwlmLa91JvYptow8WmdcsGn4X9yMkHdafWBOhZ
         /9s2unNu1nNPUkDQn7LXItcajmZr5NTsrDXq5oCvEMHsf22ZtRmR8q1ySc1lxlT2sv
         VVwNqECbwVTs0et2/6RT0L/Cap6xExXrjO4vb8RH0N5Xta2mvOy7HIBpiohMK7Fv7E
         id+IUfZWxC+4w==
Date:   Fri, 11 Mar 2022 22:14:17 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     Meng Tang <tangmeng@uniontech.com>, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, ebiederm@xmission.com,
        willy@infradead.org, nizhen@uniontech.com,
        zhanglianjie@uniontech.com, sujiaxun@uniontech.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] fs/proc: optimize exactly register one ctl_table
Message-ID: <20220312061417.bpdzf2fxf4pb2h6a@offworld>
References: <20220303070847.28684-1-tangmeng@uniontech.com>
 <624f92f0-c2a1-c7d9-a4ed-6d72c48d3ab3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <624f92f0-c2a1-c7d9-a4ed-6d72c48d3ab3@huawei.com>
User-Agent: NeoMutt/20211029
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 04 Mar 2022, Xiaoming Ni wrote:
>For example,
>
>+ #define register_sysctl_init(path, table)
>__register_sysctl_init(path, table, ARRAY_SIZE(table))
>...
>-		for (entry = table; entry->procname; entry++, node++)
>+		for (entry = table; entry->procname && num > 0; entry++, node++, num--) {

Furthermore the other iteratators could be consolidated such as:

+#define for_each_table_entry(entry, table) \
+       for ((entry) = (table); (entry)->procname; (entry)++)

.... probably before this patch.

Thanks,
Davidlohr
