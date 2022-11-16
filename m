Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A68962CF06
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Nov 2022 00:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbiKPXpb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 18:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbiKPXpa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 18:45:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93592B9D;
        Wed, 16 Nov 2022 15:45:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2575F6204F;
        Wed, 16 Nov 2022 23:45:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E3BDC433D6;
        Wed, 16 Nov 2022 23:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668642328;
        bh=0jxY8Opa4urpq+ge23FtRh3y/fBz0gl9rB0Qg9ryTIU=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=E6FwRvc2J5rVX6sv5rOmZasqjn7xiWtLetVRiVb0JnuwGkxswpoSFBQ1Kj9t6PJDk
         V9H9htjCd+3nraYDfWXE/a5vtFZnHay2VVM32Mcv9UZ78AUXadrlQARFsoJ7f87Dh5
         IcfbKHk/+x8hKHBXDL7VdH6JWx8T8UtbxJ/49pX6r2HKQGv4hagwqYoufzon0OFMgt
         TdGDqa4qPov8yGx7zssLVcab1cWXLEk/xSj68Q7Xy7Ec0GOyqLRi05eztEFT2LeGNl
         iWq4pEkTPlmq3z2t2MDqR0psb/8ZzBDauC7PpGWvUbhvv3Q7DwvLjDcefFcTpT0amG
         8XxMLnfGPk1HA==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-13ae8117023so313825fac.9;
        Wed, 16 Nov 2022 15:45:28 -0800 (PST)
X-Gm-Message-State: ANoB5pkDoRrDEwcUULiogHu36hXVx1JTzyMI42n9lOLzSMk+BIb8nOnd
        0fb1Aj1VRk2sAVDkQSAV88qLRsdiapanJRL3MSU=
X-Google-Smtp-Source: AA0mqf6VaaqxqHzy52knkr9XjLEbA/7U7ZpZSCqK75OoQ3L1+mR9W8NQVszsFW9ZsirIChQMf6IQeWc6Knbq5RrxpTY=
X-Received: by 2002:a05:6870:430a:b0:13d:5167:43e3 with SMTP id
 w10-20020a056870430a00b0013d516743e3mr8629oah.257.1668642327655; Wed, 16 Nov
 2022 15:45:27 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6839:1a4e:0:0:0:0 with HTTP; Wed, 16 Nov 2022 15:45:27
 -0800 (PST)
In-Reply-To: <20221116151726.129217-5-jlayton@kernel.org>
References: <20221116151726.129217-1-jlayton@kernel.org> <20221116151726.129217-5-jlayton@kernel.org>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Thu, 17 Nov 2022 08:45:27 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8wGREP_vvhDEpx5FbXqZQwUjwVP1NvcXTB08-JW1uVBg@mail.gmail.com>
Message-ID: <CAKYAXd8wGREP_vvhDEpx5FbXqZQwUjwVP1NvcXTB08-JW1uVBg@mail.gmail.com>
Subject: Re: [PATCH 4/7] ksmbd: use locks_inode_context helper
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        chuck.lever@oracle.com, viro@zeniv.linux.org.uk, hch@lst.de,
        Steve French <sfrench@samba.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022-11-17 0:17 GMT+09:00, Jeff Layton <jlayton@kernel.org>:
> ksmbd currently doesn't access i_flctx safely. This requires a
> smp_load_acquire, as the pointer is set via cmpxchg (a release
> operation).
>
> Cc: Namjae Jeon <linkinjeon@kernel.org>
> Cc: Steve French <sfrench@samba.org>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>

Thanks for your patch!
