Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2A177FBDE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 18:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353572AbjHQQRe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 12:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353578AbjHQQRK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 12:17:10 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E326273F;
        Thu, 17 Aug 2023 09:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=iwlDF0w6o8GP/dUtRoqadxch7elmjv+F6emLEuy5MKY=; b=Y4OB/Ij+hW95CXSkc1WHeoK3ix
        lLN4hPnl4DL2KTpeeqwTmHeTVbtFBleE0yIVYQiyQL9FpGessLT+yL/U45c4wplxLGZibOFiZIMSk
        QWzdDnBeZEPEhZAWSJJP9IYpuM3X/XWcOn++/Gez8V6eoB+aG/wDeCcBGKMg4LpcxLcX3mWglp25L
        lrGwYya+7sC9kSkgRw6oRa4D6ADUyLIQogD7mK3e7RZ1cpzmilqcTN1CtZYIfQfxRDBCCYHifc8AL
        edD2/QvHuVphQz9ufRDNq6O91eioXvhMNdPWNn7Tq1WRlo8Xa+gk0DcVowJMvUTjqKba55cljAe4Z
        tMBnbO7Q==;
Received: from 201-92-22-215.dsl.telesp.net.br ([201.92.22.215] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qWfgB-001yts-EZ; Thu, 17 Aug 2023 18:16:59 +0200
Message-ID: <c6b9fdd3-eb05-3668-a455-fb1cff365885@igalia.com>
Date:   Thu, 17 Aug 2023 13:16:52 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] btrfs-progs: Add the single-dev feature (to both
 mkfs/tune)
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, clm@fb.com, dsterba@suse.com,
        linux-fsdevel@vger.kernel.org, kernel@gpiccoli.net,
        kernel-dev@igalia.com, anand.jain@oracle.com, david@fromorbit.com,
        kreijack@libero.it, johns@valvesoftware.com,
        ludovico.denittis@collabora.com, quwenruo.btrfs@gmx.com,
        wqu@suse.com, vivek@collabora.com
References: <20230803154453.1488248-1-gpiccoli@igalia.com>
 <20230803154453.1488248-2-gpiccoli@igalia.com>
 <20230817154650.GD2934386@perftesting>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20230817154650.GD2934386@perftesting>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 17/08/2023 12:46, Josef Bacik wrote:
> [...]
>> Also, a design decision: I've skipped the btrfs_register_one_device()
>> call when mkfs was just used with the single-dev tuning, or else
>> it shows a (harmless) error and succeeds, since of course scanning
>> fails for such devices, as per the feature implementation.
>> So, I thought it was more straightforward to just skip the call itself.
>>
> 
> This is a reasonable approach.
> [...]

Thanks for the review =)


>> [...]
>>  static int convert_to_fst(struct btrfs_fs_info *fs_info)
>>  {
>>  	int ret;
>> @@ -102,6 +106,7 @@ static const char * const tune_usage[] = {
>>  	OPTLINE("-r", "enable extended inode refs (mkfs: extref, for hardlink limits)"),
>>  	OPTLINE("-x", "enable skinny metadata extent refs (mkfs: skinny-metadata)"),
>>  	OPTLINE("-n", "enable no-holes feature (mkfs: no-holes, more efficient sparse file representation)"),
>> +	OPTLINE("-s", "enable single device feature (mkfs: single-dev, allows same fsid mounting)"),
> 
> btrfstune is going to be integrated into an actual btrfs command, so we're no
> longer using short options for new btrfstune commands.  Figure out a long name
> instead and use that only.  Something like
> 
> --convert-to-single-device
> 
> as you would be using this on an existing file system.  The rest of the code is
> generally fine.  Thanks,
> 
> Josef
> 

Perfect, will do! Thanks.
