Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169085A23B2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 11:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245049AbiHZJG1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Aug 2022 05:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiHZJGZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Aug 2022 05:06:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BDBD1E33;
        Fri, 26 Aug 2022 02:06:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CEEB7B82FDC;
        Fri, 26 Aug 2022 09:06:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65133C433C1;
        Fri, 26 Aug 2022 09:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661504782;
        bh=MJyHEWzsH70GVPr7I1cPvhdiVExvL4z5DqMIQnH1W90=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=N5sraIrlQCTgPfb7HGkinp887I6d5qAv4YRZZ4bxAgwTO5WXeFHXN5+K2cJYJ/2GZ
         Iiy3HplIqzghwky/8RdpGTDZEtUEd5zGNYNaKd+rF4Aef6mxehQHE+uinKNinxaFnf
         WALviV3B8Gqj4blYDnyTXUe1GMXcpWBhmxEQYYL424diIA1AzOYdlpL+m9xsJg21Kj
         6YG5YJVPfhc9ijRrfp+BZZz49w+0nPDMgqfTE7YPXLjMuZKUZAFXnSRMlyH0vCQNAq
         +rdWpHd4xo88o+owPjUSyrMdqbvWC2ZT1YIM6wocjhxLc6lJx23QZ0xCuPnts5HiNj
         u72NcVMHi0JWg==
Received: by mail-oi1-f182.google.com with SMTP id v125so1310943oie.0;
        Fri, 26 Aug 2022 02:06:22 -0700 (PDT)
X-Gm-Message-State: ACgBeo1CZXTgQq24GiLioCAT4dNrYuHnwMpVvFK6MKVXTN8VZj3bh9zV
        /Gjl1jmZ/kzzM9AxrS+nyp7LsqmiudR2sovcHJ8=
X-Google-Smtp-Source: AA6agR4nxxXyOFT+YU8yNM87JxMkjZ5vNaSuYVMINSnYt1JdTco+e+iIEcSidTk+Oj8YCOfREsQny95p6JoVoUDfkLg=
X-Received: by 2002:a05:6808:14d5:b0:344:8f50:1f0f with SMTP id
 f21-20020a05680814d500b003448f501f0fmr1211191oiw.257.1661504781389; Fri, 26
 Aug 2022 02:06:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6838:27c7:0:0:0:0 with HTTP; Fri, 26 Aug 2022 02:06:20
 -0700 (PDT)
In-Reply-To: <PUZPR04MB63161D3BE9104FF48BD298DE81719@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <PUZPR04MB63161D3BE9104FF48BD298DE81719@PUZPR04MB6316.apcprd04.prod.outlook.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Fri, 26 Aug 2022 18:06:20 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8CHkEUc0zD+YoJTzAP91Ppf-cgBVWZ3Ap4PU3hL4njfw@mail.gmail.com>
Message-ID: <CAKYAXd8CHkEUc0zD+YoJTzAP91Ppf-cgBVWZ3Ap4PU3hL4njfw@mail.gmail.com>
Subject: Re: [PATCH] exfat: fix overflow for large capacity partition
To:     "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc:     "sj1557.seo" <sj1557.seo@samsung.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022-08-23 12:26 GMT+09:00, Sungjong Seo <sj1557.seo@samsung.com>:
>> Using int type for sector index, there will be overflow in a large
>> capacity partition.
>>
>> For example, if storage with sector size of 512 bytes and partition
>> capacity is larger than 2TB, there will be overflow.
>>
>> Fixes: 1b6138385499 ("exfat: reduce block requests when zeroing a
>> cluster")
>>
>> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
>> Reviewed-by: Andy Wu <Andy.Wu@sony.com>
>> Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>
>
> Looks good!
> Acked-by: Sungjong Seo <sj1557.seo@samsung.com>
Applied, Thanks!
>
>>
>> ---
>>  fs/exfat/fatent.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c index
>> ee0b7cf51157..41ae4cce1f42 100644
>> --- a/fs/exfat/fatent.c
>> +++ b/fs/exfat/fatent.c
>> @@ -270,8 +270,7 @@ int exfat_zeroed_cluster(struct inode *dir, unsigned
>> int clu)
>>  	struct super_block *sb = dir->i_sb;
>>  	struct exfat_sb_info *sbi = EXFAT_SB(sb);
>>  	struct buffer_head *bh;
>> -	sector_t blknr, last_blknr;
>> -	int i;
>> +	sector_t blknr, last_blknr, i;
>>
>>  	blknr = exfat_cluster_to_sector(sbi, clu);
>>  	last_blknr = blknr + sbi->sect_per_clus;
>> --
>> 2.25.1
>
>
>
