Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD36E7A7CCC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 14:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbjITMEO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 08:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbjITMEN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:04:13 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7A9B6;
        Wed, 20 Sep 2023 05:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ArH6Ez/Ai3EV6hOS18A12MH9ewrotbWIDmBOHOMkd98=; b=en4g9sMpfnJNaH4Tla19g5iFs2
        F3hb47MPAlZKPTc5lSMzdfIJP4M9W6MZXHYEZlvEIbk2ce/kDcYgcCWv5U0y1FVDyZ21nqxPneRGl
        A0wmFo2II/WDpwe2aU2wPrGwjXcQcFYgSRMBI96zPyoPeQbpxOjL3kDNQhlvX7w4ow8oW/qXaohUA
        X7S9PL1bxtF1Fd/j/8JJbMgFJj/pgTEN8KFclPcBQ1wEPKD48rQFpGWjvqjqogfwBjgOX6LbCuouk
        KyJMOj/TlOSqRzVTUJLyYoOJiYPiz4Dc35yBndTDjXsq/E9NKJF3bV9C5e+gugW2UUc8rq+O/hfWp
        Di4jVEpg==;
Received: from [187.56.161.251] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qivvy-006UyG-DA; Wed, 20 Sep 2023 14:03:58 +0200
Message-ID: <b71f8c4b-1e70-605c-8903-ab1d16c1ef73@igalia.com>
Date:   Wed, 20 Sep 2023 09:03:49 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4 2/2] btrfs: Introduce the temp-fsid feature
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        dsterba@suse.cz, linux-fsdevel@vger.kernel.org,
        kernel@gpiccoli.net, kernel-dev@igalia.com, david@fromorbit.com,
        kreijack@libero.it, johns@valvesoftware.com,
        ludovico.denittis@collabora.com, quwenruo.btrfs@gmx.com,
        wqu@suse.com, vivek@collabora.com
References: <20230913224402.3940543-1-gpiccoli@igalia.com>
 <20230913224402.3940543-3-gpiccoli@igalia.com>
 <f976c005-29fe-4f7e-e1d2-5262d638761a@oracle.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <f976c005-29fe-4f7e-e1d2-5262d638761a@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 19/09/2023 08:06, Anand Jain wrote:
> [...]
>> +	while (dup_fsid) {
>> +		dup_fsid = false;
>> +		generate_random_uuid(vfsid);
>> +
>> +		list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
>> +			if (!memcmp(vfsid, fs_devices->fsid, BTRFS_FSID_SIZE) ||
>> +			    !memcmp(vfsid, fs_devices->metadata_uuid,
>> +				    BTRFS_FSID_SIZE))
>> +				dup_fsid = true;
>> +		}
> 		
> 
> I've noticed this section of the code a few times, but I don't believe
> I've mentioned it before. We've been using generate_random_guid() and
> generate_random_uuid() without checking for UUID clashes. Why extra
> uuid clash check here?
> 

Hi Anand, what would happen if the UUID clashes here? Imagine we have
another device with the same uuid (incredibly small chance, but...), I
guess this would break in the subsequent path of fs_devices addition,
hence I added this check, which is really cheap. We need to generate a
really unique uuid here as the temp one.

Do you see any con in having this check? I'd say we should maybe even
check in the other places the code is generating a random uuid but not
checking for duplicity currently...
