Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192497AA527
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 00:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjIUWgm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 18:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjIUWgk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:36:40 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E77299;
        Thu, 21 Sep 2023 15:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rR2cZd7yur01Ir3SkPw5P3RjMdpMb53gnLRDGYuXndA=; b=DwZZODBLwl+00bYmMdauwD8wQG
        5KM8JdELqVgTHVoZBKEviHh9AzcrtpldekxKHJZLU0ehPGmnQOY6rgLhoUvoUTPHyZDODRVkM2uRV
        K0H+1L2/7a3nmL/Fc/MpohZXioiF/y5zDp71PiRaKkPlvzNI7v7YkF9r5bRDTo68du8kiPlHtBVeT
        l6uBN1LssUKM/Z6c7Fb5s/UQwt35NNMmZwEzoxQ2W+7gBfMhArBd4c877WHhj42MOLTF9TwrsmjwP
        EY61SqSMNM3fQKkg5nsNz0Maj3WJIidwj8B9GDMXkCvKpELgR8LsBsYfwgtwQUh6rB1UAyw+NGVNf
        OeQgnhbA==;
Received: from [187.56.161.251] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qjSHZ-0076Kg-6E; Fri, 22 Sep 2023 00:36:25 +0200
Message-ID: <cfb0446d-48bd-40be-32d2-21bdc6b1e06b@igalia.com>
Date:   Thu, 21 Sep 2023 19:36:16 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4 2/2] btrfs: Introduce the temp-fsid feature
Content-Language: en-US
To:     dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-fsdevel@vger.kernel.org,
        kernel@gpiccoli.net, kernel-dev@igalia.com, david@fromorbit.com,
        kreijack@libero.it, johns@valvesoftware.com,
        ludovico.denittis@collabora.com, quwenruo.btrfs@gmx.com,
        wqu@suse.com, vivek@collabora.com
References: <20230913224402.3940543-1-gpiccoli@igalia.com>
 <20230913224402.3940543-3-gpiccoli@igalia.com>
 <20230918215250.GQ2747@twin.jikos.cz>
 <cff46339-62ff-aecc-2766-2f0b1a901a35@igalia.com>
 <a5572d9e-4028-b3ca-da34-e9f5da95bc34@oracle.com>
 <9ee57635-81bf-3307-27ac-8cb7a4fa02f6@igalia.com>
 <20230920183756.GG2268@twin.jikos.cz>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20230920183756.GG2268@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 20/09/2023 15:37, David Sterba wrote:
> [...]
>> The way I think we could resolve this is by forbidding mounting a
>> temp-fsid twice - after the random uuid generation, we could check for
>> all fs_devices present and if any of it has the same metadata_uuid, we
>> check if it's the same dev_t and bail.
>>
>> The purpose of the feature is for having the same filesystem in
>> different devices able to mount at the same time, but on different mount
>> points. WDYT?
> 
> The subvolume mount is a common use case and I hope it continues to
> work. Currently it does not seem so as said above, for correctness we
> may need to prevent it. We might find more and this should be known or
> fixed before final release.
> 

Thanks David, fully agree. And special thanks Anand for unveiling this
important flaw. I'll work a small follow-up patch preventing that (will
be in conference + travels so that might take some days...)

Cheers!
