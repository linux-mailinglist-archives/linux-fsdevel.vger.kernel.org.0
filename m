Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82CA653B1B6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jun 2022 04:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbiFBCti (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jun 2022 22:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbiFBCth (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jun 2022 22:49:37 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DBB2271A1
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jun 2022 19:49:36 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id w3so3361329plp.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jun 2022 19:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VWWg3YVRxhiQ7jHH+pXcvjeyZQ2jJOq1eY93gu+tH5s=;
        b=qCCehyoFpzCwgn+9xbvDhWBL6q04yq1m8emLpqPGttNYzw97ayElj5ntE+7UdFUK/e
         IOGaoPz7uwHXJGpBXJQM9PZpVp6h0tacXf1y2s5mY2id5g/OzVovfFiHRoS/gCe793/1
         rFtFgL1YsuaZuUfnqoDmGJAjRtMQihlJIPx1Sl5BARISM3a5XmeWrWHaEQBRrY8lsD4s
         nUyKYLbDWWwj46zx5gB46zszH+PIpvO5vwMyHh/0X5SySLAyqbZuMeUBXoKb6B5E0dHO
         ZOGhfX6q8vKP3ld76DHVnc7wvuPeLa4jI9ww14Gls5hheRoQvt905ItgPhBsIQo7gMMv
         VBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VWWg3YVRxhiQ7jHH+pXcvjeyZQ2jJOq1eY93gu+tH5s=;
        b=ubabV4pZq933LjKWhzlF0745Xyu+j1c4/zCFsWoU0wS8DGgDPppLcJIVpJt7NIz/AX
         bgaL0JP8VxUI0VulUJCk9yDspGqunqbu7RBsf9P60zWeK95VJ29vL+QuljEpjUzxefsb
         2Lq1zzhLiGsIT3B6OA89/38pXqjtagHpe7vt7rA6XdXbbAlMv2CTkISW41iIo7Ga60As
         DR/FuFtsOF7yq+c50UaO/FVMFW8EzgmZuiaiV5qJ/6GSTr9QdggwQOr9qoBk09dYBJOD
         rvQ1u9M3ydYZQh17QBfCTSIwlzuNju4PYps9DHUsyiFvN3UBG+Fx/YpHCB13rKRrxL14
         42Zw==
X-Gm-Message-State: AOAM531NFbyFAv8etJSk41EOnrFFJWPAh/WCdFbISdDrShFd7EmnHZs3
        AQDO389mz4o7fywAGXhhNp+ifQ==
X-Google-Smtp-Source: ABdhPJxqqJj+TJXJ14GCjUA5BgWbLuxALqxK/bpj324gKUBlnp8/DLiTFLz8vPjafDgNAbFfvv7DgA==
X-Received: by 2002:a17:903:186:b0:161:f394:3e75 with SMTP id z6-20020a170903018600b00161f3943e75mr2516114plg.113.1654138176414;
        Wed, 01 Jun 2022 19:49:36 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:2468:2a68:7bbe:680c])
        by smtp.gmail.com with ESMTPSA id k14-20020a63560e000000b003c6a71b2ab7sm1946886pgb.46.2022.06.01.19.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 19:49:36 -0700 (PDT)
Date:   Thu, 2 Jun 2022 10:49:31 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH 2/2] filemap: Remove add_to_page_cache() and
 add_to_page_cache_locked()
Message-ID: <YpglO7R5ZQa7Ql24@FVFYT0MHHV2J.googleapis.com>
References: <20220601192333.1560777-1-willy@infradead.org>
 <20220601192333.1560777-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601192333.1560777-2-willy@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 01, 2022 at 08:23:33PM +0100, Matthew Wilcox (Oracle) wrote:
> These functions have no more users, so delete them.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
