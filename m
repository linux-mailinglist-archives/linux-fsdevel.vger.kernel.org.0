Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA366E7EE1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 17:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbjDSPuy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 11:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233691AbjDSPuo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 11:50:44 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3A5AD14;
        Wed, 19 Apr 2023 08:50:20 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a5so26396557ejb.6;
        Wed, 19 Apr 2023 08:50:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681919371; x=1684511371;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eOUql/Ro9WMFOAkCEiG4JHxRup0JACmg1t6/598D9Co=;
        b=ZWM2zrXfhtV/QPwHWKu0Xd2NIH2Dwt2+fAdSZMP/EKAjohBUqwURiwwYg4sxRoFWv7
         TvX/RHZHIPcp4EL1ohgY3TfrUBiog0fuyjWApEIR/YYrM0ea0n1G40Cfw7GriWgIjrLh
         diNooW/Wh0Fg2vAm6IEstcPXUuHw/lAfbc5S9bV7yCxAE/krnRdv+nV115joymtI04kM
         LZrwgzr0V52Cdhg00o4AjSi9MRitUjhX3uSmXEN9sL07w1njMOXQuvq5pK0W/cL54cmX
         hp/Om1geOVXFsCSHcuit/fE7S6EParBOetrJHGcSLcaxFp6sC1RzsOKPvRhZYZvVqk+s
         lWGw==
X-Gm-Message-State: AAQBX9e5nacbjl0OzMK1VdkflBrs9GX/AzSgyNdJqvp92xBj1FQmAx86
        pWhacyfqZ5Rq1jKfaW2uZNc=
X-Google-Smtp-Source: AKy350aGL2zkmqe4oR+uMj3AvMO3DzPKJ+2nYfKvNg29gbfKfCGrXHIDbSOpWzqvwSwoi/4pOYVBdg==
X-Received: by 2002:a17:907:98ef:b0:92c:8e4a:1a42 with SMTP id ke15-20020a17090798ef00b0092c8e4a1a42mr15999637ejc.32.1681919370719;
        Wed, 19 Apr 2023 08:49:30 -0700 (PDT)
Received: from [192.168.32.129] (aftr-62-216-205-204.dynamic.mnet-online.de. [62.216.205.204])
        by smtp.gmail.com with ESMTPSA id o26-20020a1709061d5a00b0094e44899367sm9373601ejh.101.2023.04.19.08.49.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 08:49:30 -0700 (PDT)
Message-ID: <0388e267-6a5f-85b8-83eb-62ea5aae06e1@kernel.org>
Date:   Wed, 19 Apr 2023 17:49:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
To:     Matthew Wilcox <willy@infradead.org>
Cc:     axboe@kernel.dk, johannes.thumshirn@wdc.com, agruenba@redhat.com,
        cluster-devel@redhat.com, damien.lemoal@wdc.com,
        dm-devel@redhat.com, dsterba@suse.com, hare@suse.de, hch@lst.de,
        jfs-discussion@lists.sourceforge.net, kch@nvidia.com,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-raid@vger.kernel.org, ming.lei@redhat.com,
        rpeterso@redhat.com, shaggy@kernel.org, snitzer@kernel.org,
        song@kernel.org, Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <20230419140929.5924-1-jth@kernel.org>
 <20230419140929.5924-20-jth@kernel.org>
 <ZD/4b9ZQ1YZRTgHL@casper.infradead.org>
Content-Language: en-US
From:   Johannes Thumshirn <jth@kernel.org>
Subject: Re: [PATCH v3 19/19] block: mark bio_add_page as __must_check
In-Reply-To: <ZD/4b9ZQ1YZRTgHL@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 19/04/2023 16:19, Matthew Wilcox wrote:
> On Wed, Apr 19, 2023 at 04:09:29PM +0200, Johannes Thumshirn wrote:
>> Now that all users of bio_add_page check for the return value, mark
>> bio_add_page as __must_check.
> 
> Should probably add __must_check to bio_add_folio too?  If this is
> really the way you want to go ... means we also need a
> __bio_add_folio().

I admit I haven't thought of folios, mea culpa.

3 of the callers of bio_add_folio() don't check the return value:
$ git grep -E '\sbio_add_folio\b'
fs/iomap/buffered-io.c:         bio_add_folio(ctx->bio, folio, plen, poff);
fs/iomap/buffered-io.c: bio_add_folio(&bio, folio, plen, poff);
fs/iomap/buffered-io.c:         bio_add_folio(wpc->ioend->io_bio, folio, 
len, poff);

But from a quick look they look OK to me.

Does that look reasonable to you:

diff --git a/block/bio.c b/block/bio.c
index fd11614bba4d..f3a3524b53e4 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1138,6 +1138,14 @@ int bio_add_page(struct bio *bio, struct page *page,
  }
  EXPORT_SYMBOL(bio_add_page);

+void __bio_add_folio(struct bio *bio, struct folio *folio, size_t len,
+                    size_t off)
+{
+       WARN_ON_ONCE(len > UINT_MAX);
+       WARN_ON_ONCE(off > UINT_MAX);
+       __bio_add_page(bio, &folio->page, len, off);
+}
+
  /**
   * bio_add_folio - Attempt to add part of a folio to a bio.
   * @bio: BIO to add to.


Byte,
	Johannes
