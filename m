Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952C96FFC9F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 May 2023 00:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239405AbjEKW2q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 May 2023 18:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239188AbjEKW2o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 May 2023 18:28:44 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4CB273B
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 15:28:42 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64a9335a8e7so1561982b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 15:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683844122; x=1686436122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=foguPMzaG5JiKYkGBK5Zqr8oTB+NWVY0GCMBbESmVbo=;
        b=fE3rVckTldIGJ9X79t1Tocx/fvHS8/EWaaZUWVMfpCQjD6wKu7leVkN9G5nHE7F2LC
         p4WBsp2m0LR3mee1GBx75i7GQ1hFNp4aJ0AeK9wRgq5DxKNNm6lsnOs+r+KExblYrhxr
         az+pMa5mQwMDktKT2xO108h0iA2YD2f2nwjW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683844122; x=1686436122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foguPMzaG5JiKYkGBK5Zqr8oTB+NWVY0GCMBbESmVbo=;
        b=UQ85aqoxtdnXOqYDSM7fV3Vr+eVBeaCuhAwbODsn47Im5yPGQZcpCH8sUmSHipz2WW
         Eqik3YW+OPlrk67XNG7SMz8R+HLEgVcVadh6CgwDBAogBDAkScxFVjzTc4ksKokSid8B
         DmA7aI7ERC8sVSE6PeAwRYKkD4T1AKD6m8L8oF1k2maExTXSewSn6nGT/1FzSZd5xOQ8
         a/BSwwYL1yPLSgtnv0nZ5lguPGeOIQzj0tgJeH7OceOZ31WqBtK3bHlttAdYMJa6z9q5
         XfCeU1iS0U76PmniquRd+cipuxN931qUD3EpG2GZrWYaRn9qlv77QZ/WSPDshfaFjwHy
         HPqw==
X-Gm-Message-State: AC+VfDz1dmBoEvhFhjxvxiU9WYWs8YHMv3uYJhSed4FefipczdfQfTud
        2uXQUsuEEuxdAzGVpvnPzu+R8ZlI3YE2RNJL8Eb4gg==
X-Google-Smtp-Source: ACHHUZ6mEsMPqSDmeIgz0bMbow4zeO58axDoPLJOCw723w8mEoGZDcn2G0FDhPsF6SBJe8srfCjV2Q==
X-Received: by 2002:a05:6a20:8e14:b0:101:3c60:6794 with SMTP id y20-20020a056a208e1400b001013c606794mr12671176pzj.2.1683844121954;
        Thu, 11 May 2023 15:28:41 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p38-20020a631e66000000b0052c766b2f52sm5515338pgm.4.2023.05.11.15.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 15:28:41 -0700 (PDT)
Date:   Thu, 11 May 2023 15:28:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH 07/32] mm: Bring back vmalloc_exec
Message-ID: <202305111525.67001E5C4@keescook>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-8-kent.overstreet@linux.dev>
 <3508afc0-6f03-a971-e716-999a7373951f@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3508afc0-6f03-a971-e716-999a7373951f@wdc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 10, 2023 at 03:05:48PM +0000, Johannes Thumshirn wrote:
> On 09.05.23 18:56, Kent Overstreet wrote:
> > +/**
> > + * vmalloc_exec - allocate virtually contiguous, executable memory
> > + * @size:	  allocation size
> > + *
> > + * Kernel-internal function to allocate enough pages to cover @size
> > + * the page level allocator and map them into contiguous and
> > + * executable kernel virtual space.
> > + *
> > + * For tight control over page level allocator and protection flags
> > + * use __vmalloc() instead.
> > + *
> > + * Return: pointer to the allocated memory or %NULL on error
> > + */
> > +void *vmalloc_exec(unsigned long size, gfp_t gfp_mask)
> > +{
> > +	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
> > +			gfp_mask, PAGE_KERNEL_EXEC, VM_FLUSH_RESET_PERMS,
> > +			NUMA_NO_NODE, __builtin_return_address(0));
> > +}
> > +EXPORT_SYMBOL_GPL(vmalloc_exec);
> 
> Uh W+X memory reagions.
> The 90s called, they want their shellcode back.

Just to clarify: the kernel must never create W+X memory regions. So,
no, do not reintroduce vmalloc_exec().

Dynamic code areas need to be constructed in a non-executable memory,
then switched to read-only and verified to still be what was expected,
and only then made executable.

-- 
Kees Cook
