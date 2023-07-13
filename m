Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8E1751804
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 07:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbjGMFZe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 01:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbjGMFZd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 01:25:33 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5504810FA;
        Wed, 12 Jul 2023 22:25:32 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b89cfb4571so2950335ad.3;
        Wed, 12 Jul 2023 22:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689225932; x=1691817932;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UESteaLAV8KfrG3qrb8wWH+QVqIMSyfd5YAOAYDV740=;
        b=gpYY5epNFqCI+fADQwTTLP+3J838qDTMHdOPYXZziMUyy4/jdZuhU1IL8RDzMSwvT5
         XFcK9fNmXvJI8MWqMyGWc3+8kb4j6ct08DAGAaftSWqYuZkZHU/NxyCcWq3RYoyX6VsI
         5sH82nbJnAYIlvEJjTaNM6ukgh9JWF19xYjFGQCC4d7W4Tt9ssiVYlkKvxAuO8A3LzhM
         RE4ecxy9bd6JPv9kWM96EKkiT9zo08avvsY26uGkO0GtRclrmOAfo82WmJiiC147Gdei
         PGhiVGIw3kGoVVv6p9KkPb4XeJG/75QABS9GidMwuFuUQ8bpf8SWBIY6wDRCMHoD578C
         HWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689225932; x=1691817932;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UESteaLAV8KfrG3qrb8wWH+QVqIMSyfd5YAOAYDV740=;
        b=UKiWY7Pjaja4TAXMMVPEdqUProhUdjGjg0U6cVaj6ZaOLk5cOeIStv8DAtY/pCiK9W
         +tlbKTYOM5E2fp5F+rd8O+XzalAPw3uhYLWoGoxRHQ+KG8TOwAkMJ71WoScvcllN+QrA
         0nK3mbFe5ojIKvS9TQvB4fot9AlH/fNdGjV3UZSnWs8KsW1bukPj048b/KjIzCkjtrpE
         dc7o9lbm6Lzv5dNs4UbnHRtAOXg0cnEcZ1kDJgqHvnSM42V2E2/VOr6iW2MDSzr8iTDS
         5PDN8C+H8cDullv8+O2wAR7XyPn88AzPW8r27p5jB+QMKARrEyDaQanWotO6pXrrP6C6
         yRrA==
X-Gm-Message-State: ABy/qLbmWdn5tRvaBG7UU2dJncrR/GpT8SHi4roN0c8Q6MR1B4db56Ar
        Q3ghkzPEBlm5GsqceTr10zQ=
X-Google-Smtp-Source: APBJJlHCOzcaNxi3lBhChEz79Cyw4VHRKVWDH98pzPqLwW4dAAG4PvpytR5z8rLBjETl/r+rsNkIEw==
X-Received: by 2002:a17:902:da88:b0:1b8:4e00:96b with SMTP id j8-20020a170902da8800b001b84e00096bmr809236plx.9.1689225931598;
        Wed, 12 Jul 2023 22:25:31 -0700 (PDT)
Received: from dw-tp (175.101.8.98.static.excellmedia.net. [175.101.8.98])
        by smtp.gmail.com with ESMTPSA id w21-20020a170902d71500b001ab18eaf90esm4939825ply.158.2023.07.12.22.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 22:25:30 -0700 (PDT)
Date:   Thu, 13 Jul 2023 10:55:20 +0530
Message-Id: <87351s8jsv.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     "Darrick J. Wong" <djwong@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 5/9] iomap: Remove unnecessary test from iomap_release_folio()
In-Reply-To: <20230713044558.GJ108251@frogsfrogsfrogs>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Darrick J. Wong" <djwong@kernel.org> writes:

> [add ritesh]
>
> On Mon, Jul 10, 2023 at 02:02:49PM +0100, Matthew Wilcox (Oracle) wrote:
>> The check for the folio being under writeback is unnecessary; the caller
>> has checked this and the folio is locked, so the folio cannot be under
>> writeback at this point.
>> 
>> The comment is somewhat misleading in that it talks about one specific
>> situation in which we can see a dirty folio.  There are others, so change
>> the comment to explain why we can't release the iomap_page.
>> 
>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> ---
>>  fs/iomap/buffered-io.c | 9 ++++-----
>>  1 file changed, 4 insertions(+), 5 deletions(-)
>> 
>> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
>> index 1cb905140528..7aa3009f907f 100644
>> --- a/fs/iomap/buffered-io.c
>> +++ b/fs/iomap/buffered-io.c
>> @@ -483,12 +483,11 @@ bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags)
>>  			folio_size(folio));
>>  
>>  	/*
>> -	 * mm accommodates an old ext3 case where clean folios might
>> -	 * not have had the dirty bit cleared.  Thus, it can send actual
>> -	 * dirty folios to ->release_folio() via shrink_active_list();
>> -	 * skip those here.
>> +	 * If the folio is dirty, we refuse to release our metadata because
>> +	 * it may be partially dirty.  Once we track per-block dirty state,
>> +	 * we can release the metadata if every block is dirty.
>
> Ritesh: I'm assuming that implementing this will be part of your v12 series?

No, if it's any optimization, then I think we can take it up later too,
not in v12 please (I have been doing some extensive testing of current series).
Also let me understand it a bit more.

@willy,
Is this what you are suggesting? So this is mainly to free up some
memory for iomap_folio_state structure then right?
But then whenever we are doing a writeback, we anyway would be
allocating iomap_folio_state() and marking all the bits dirty. Isn't it
sub-optimal then?  

@@ -489,8 +489,11 @@ bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags)
         * it may be partially dirty.  Once we track per-block dirty state,
         * we can release the metadata if every block is dirty.
         */
-       if (folio_test_dirty(folio))
+       if (folio_test_dirty(folio)) {
+               if (ifs_is_fully_dirty(folio, ifs))
+                       iomap_page_release(folio);
                return false;
+       }
        iomap_page_release(folio);
        return true;
 }

(Ignore the old and new apis naming in above. It is just to get an idea)

-ritesh

>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
>
> --D
>
>>  	 */
>> -	if (folio_test_dirty(folio) || folio_test_writeback(folio))
>> +	if (folio_test_dirty(folio))
>>  		return false;
>>  	iomap_page_release(folio);
>>  	return true;
>> -- 
>> 2.39.2
>> 
