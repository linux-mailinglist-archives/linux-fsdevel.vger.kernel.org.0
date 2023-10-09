Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACD67BE920
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 20:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbjJISUo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 14:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234547AbjJISUm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:20:42 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C35A9C;
        Mon,  9 Oct 2023 11:20:39 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-406402933edso44999455e9.2;
        Mon, 09 Oct 2023 11:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696875638; x=1697480438; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oc0nbYwvTpqhRguEfQQTyDgA4rUKYn1mDLi3z4hzlZ8=;
        b=AbQAaApaxHS+fhZNxFsksxu6iLB8TXptb0PuyO4I5glC+rCW5dpebOWtkY/He1lEcD
         B+P29quuOFenfPh1PUeiTiE7aTv8soc7yPiL9aEJHDwBSsRHFs/LnFVhKnilaIdR9DRu
         Lx9rdS/Lr5TdhWUz1XzSuSoyIZpTPeFmUUO5ms38eBJSjM/PrUG+CcgVUYjCjs9K/NuR
         w1IJk3BCvYQHEED5dwb1VXkf+X5UUADMS9UVTqNu5uxcLdvwXptmtFsSg62oMftiYR3p
         8QXdSERbroA32fDDPJbyB7vKhD+RUEI5ouP8worKzmCQyHL0cW/3CqXaPLSPJabKH80u
         BJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696875638; x=1697480438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oc0nbYwvTpqhRguEfQQTyDgA4rUKYn1mDLi3z4hzlZ8=;
        b=FvxX0KdgVKH66OmWvz+UTX7z2xvPsm12vHvFxIEpN2MtUbyBxGQaDefDlPsmeJKKzM
         AtEVmBknHoVlgNAzpqtboO9DN3rXK87k3DracMTuvFs74P5eGWvbv3WtN/lSBN/vt+PC
         7cLAktaVdnngjXJnmiFzazA8LSluc2CNgsRrIZQhi9K63fQbFqTE+hSo0EiTlYRjSGrf
         CQx6YpE5WJhXSENuiVSZa1IQHhwxIg234LBqZKcqFHHAAVUAPp/zFI9lVL0Px818ZLRg
         +H3SuqWQ7pS7ifSiFOrD/Yq4VkqNA38BRQSVnaXIJDdephHCnHvLDCQe4WRaQjpCO+/U
         kQ+w==
X-Gm-Message-State: AOJu0YzY3Nn+pZkEoxhQfRDURfC8O9vbyvmnJ+9JdUfuqZ2GBV827C7/
        crtOMY01NBp94wbVOGvhYlk=
X-Google-Smtp-Source: AGHT+IGfcDtfe4ydZ2UzcW8YtqCbLsCspc7CXkeTrTBQMxNmzlEg94yh27Yrc1mXwnP+2Hn4rbiIPA==
X-Received: by 2002:a5d:4c8a:0:b0:313:ecd3:7167 with SMTP id z10-20020a5d4c8a000000b00313ecd37167mr13988616wrs.42.1696875637878;
        Mon, 09 Oct 2023 11:20:37 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id bd5-20020a05600c1f0500b004030e8ff964sm14235674wmb.34.2023.10.09.11.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 11:20:37 -0700 (PDT)
Date:   Mon, 9 Oct 2023 19:20:36 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "=Liam R . Howlett" <Liam.Howlett@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/4] mm: make vma_merge() and split_vma() internal
Message-ID: <3b46dabf-b9d8-46bc-8cec-3b7aa3b7a609@lucifer.local>
References: <cover.1696795837.git.lstoakes@gmail.com>
 <6237f46d751d5dca385242a92c09169ad4d277ee.1696795837.git.lstoakes@gmail.com>
 <4d8968e8-a103-8320-fce6-d2a78fbf05ba@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d8968e8-a103-8320-fce6-d2a78fbf05ba@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 09, 2023 at 05:45:26PM +0200, Vlastimil Babka wrote:
> On 10/8/23 22:23, Lorenzo Stoakes wrote:
> > Now the vma_merge()/split_vma() pattern has been abstracted, we use it
>
> "it" refers to split_vma() only so "the latter" or "split_vma()"?
>

I mean to say the pattern of attempting vma_merge(), then if that fails,
splitting as necessary. I will try to clarify the language in v2.

> > entirely internally within mm/mmap.c, so make the function static. We also
> > no longer need vma_merge() anywhere else except mm/mremap.c, so make it
> > internal.
> >
> > In addition, the split_vma() nommu variant also need not be exported.
> >
> > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>

Thanks!
