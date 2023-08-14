Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4D477B081
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 06:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbjHNEgn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 00:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbjHNEgH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 00:36:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D909B10C0
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Aug 2023 21:36:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7940C62328
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 04:36:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE7DC433C9
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 04:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691987761;
        bh=Yb2TTZzQADkJgXh0bzJnd4Mfb5K26z6CTI9tMxOZXKE=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=MYqgf9O1mr07HvnhVwbsusHH+IyK+8nr3V//XP0s9e5mvd+bYY2zMK74lmsck/bML
         Zms5zVkZsYY/JQxLqw4XwWzTC3RME6PEc9tduDczCqssYu2H3+JIDmM+HObW/TkimQ
         Syq5TSsMlEpnzD5xhMz9Z5Avthh2Ngf2rjyco4+Re0P6SyjMcTQo0PZT0DkVoFTk69
         /um1ilaWulvqPWKVtZJu0UWHbjMSOzNFTqZ6jmEP3WMVNfaEhxyQwhK6pr/zXD/wDh
         X1h2670Zo0ouIsn/CvreSX40aWLezQOB22g5+LLOJKQ33W27w1nEx02fBgeN/sedtm
         RNAfhINQ1wAjg==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-56c711a88e8so3000607eaf.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Aug 2023 21:36:01 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxkz6+U8Q2SCbMF4GThmNk6vCtOMfy1q8tHWLooLtmBMJNetOCw
        Pv3SmqnYydDjekuu4GNgOJm22DaUX/KhSb48/+I=
X-Google-Smtp-Source: AGHT+IFxdrSHXBCLWEiFex6Os6k96OD+uEk/fqs5ra21d92jxb4p1vLSyHIaTrop9XadsU/7lZn3aSA61oeCvZwM8wI=
X-Received: by 2002:a05:6871:591:b0:1be:fc52:d532 with SMTP id
 u17-20020a056871059100b001befc52d532mr9393798oan.23.1691987761064; Sun, 13
 Aug 2023 21:36:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:14c:0:b0:4e8:f6ff:2aab with HTTP; Sun, 13 Aug 2023
 21:36:00 -0700 (PDT)
In-Reply-To: <PUZPR04MB631612A7F55F8B5523E631BA8124A@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <PUZPR04MB631612A7F55F8B5523E631BA8124A@PUZPR04MB6316.apcprd04.prod.outlook.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Mon, 14 Aug 2023 13:36:00 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8F2_b3R0WG-kR1w5_T36s2wT6_QmN9M+HggygsmKmLzw@mail.gmail.com>
Message-ID: <CAKYAXd8F2_b3R0WG-kR1w5_T36s2wT6_QmN9M+HggygsmKmLzw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] exfat: change to get file size from DataLength
To:     "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc:     "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[snip]
> +static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter
> *iter)
> +{
> +	ssize_t ret;
> +	struct file *file = iocb->ki_filp;
> +	struct inode *inode = file_inode(file);
> +	struct exfat_inode_info *ei = EXFAT_I(inode);
> +	loff_t pos = iocb->ki_pos;
> +	loff_t valid_size;
> +
> +	inode_lock(inode);
> +
> +	valid_size = ei->valid_size;
> +
> +	ret = generic_write_checks(iocb, iter);
> +	if (ret < 0)
> +		goto unlock;
> +
> +	if (pos > valid_size) {
> +		ret = exfat_file_zeroed_range(file, valid_size, pos);
Can we use block_write_begin instead of cont_write_begin in exfat_write_begin?

> +		if (ret < 0 && ret != -ENOSPC) {
> +			exfat_err(inode->i_sb,
> +				"write: fail to zero from %llu to %llu(%ld)",
> +				valid_size, pos, ret);
> +		}
> +		if (ret < 0)
> +			goto unlock;
> +	}
> +
> +	ret = __generic_file_write_iter(iocb, iter);
> +	if (ret < 0)
Probably It should be if (ret <= 0)...

> +		goto unlock;
> +
> +	if (pos + ret > i_size_read(inode))
> +		i_size_write(inode, pos + ret);
> +
> +	if (pos + ret > ei->valid_size)
> +		ei->valid_size = pos + ret;
> +
> +	/*
> +	 * If valid_size is extended with sector-aligned length in
> +	 * exfat_get_block(), set to the writren length.
> +	 */
> +	if (i_size_read(inode) < ei->valid_size)
> +		ei->valid_size = i_size_read(inode);
> +
> +	mark_inode_dirty(inode);
> +	inode_unlock(inode);
> +
> +	if (pos > valid_size && iocb_is_dsync(iocb)) {
> +		ssize_t err = vfs_fsync_range(file, valid_size, pos - 1,
> +				iocb->ki_flags & IOCB_SYNC);
It should be moved to exfat_file_zeroed_range() ?

Thanks.
