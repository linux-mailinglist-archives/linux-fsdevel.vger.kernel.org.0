Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8CF6EB37A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 23:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbjDUVPT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 17:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjDUVPS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 17:15:18 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CAF188;
        Fri, 21 Apr 2023 14:15:16 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-2f4214b430aso1383283f8f.0;
        Fri, 21 Apr 2023 14:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682111715; x=1684703715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pYemjpbkRi2oy1gk2dZg3F49sXkrYi0WyWJsWHJ+bCc=;
        b=P62P/OruZAVlueznZ367JkDo+XP+EKvBDhC93hHe3XP5aklq/ErEOwTGeHV+7EBc+B
         Ntm0CxvLtcrcS2Y2DwP6BldZDddc3TIVE5tiYC0jTO0+tl3ay7qCptur+0Y0zIHNBtGn
         dx6ShEl3OC0nQ8LubclxHxbnoYQur7jiDFlmBu0vSJrpLV3Z87o1FKRp2jAwEnNg8N7P
         7Z+tatjF7fv9ee+yFLd+DgT4hm9Z3kuyPK6PZH1Ayk9yWmS/etjtzydK/09Xf4T2zZI9
         VpoUuPtqTLD+N5pGuD/PWG3CNg1ZM9+p45H14rVt+hdBqacGGBbgqDJmxjP7/1naVaGV
         wXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682111715; x=1684703715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYemjpbkRi2oy1gk2dZg3F49sXkrYi0WyWJsWHJ+bCc=;
        b=N+Qnle+8DMleU10la1NECbEVG/oBSiaESDHJCUVIVAWbSPVqQkHvKMIBu3B1HVclCw
         jim0FGRCgx4CmnP+fRIMOVskPantkNImxK67W8veRjB/q5Lfw0q5jDJ0CMuLxU4XJi1U
         xFQkWn1wT5q9j5x7F8Fc4t80hl6QEeJf7mP9UGoa6Is/caUwA/tVYLihmGVf0sIvB+s1
         56gv39wFNECqCAmOk88Gxpd9z+WuQtQetATXlHAB/KUsfT0OL6Sma05qrka+PhO44EOp
         dSSncFs/94JNmT6XWAaXIEXf/Dd8J1Z1nKXQsJJ5lEtgYU+xakN0mn7QH9Em+jEGk9Bj
         ldcQ==
X-Gm-Message-State: AAQBX9c5C+K3OedlQLBdwgJtyf6qDnIP09/+KwLpqJReAQe7qhM3+wCE
        +VNX5FwPc6ng0lk1tJ3phDQ=
X-Google-Smtp-Source: AKy350bjm6qasgR1ATZDyDivme4jaHw7kRMfjLumtvBB2KSQxB18B6/WtMw/1Y8gZE90fu321BdqVQ==
X-Received: by 2002:adf:ded1:0:b0:2f4:d4a3:c252 with SMTP id i17-20020adfded1000000b002f4d4a3c252mr3967622wrn.3.1682111714956;
        Fri, 21 Apr 2023 14:15:14 -0700 (PDT)
Received: from localhost (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.gmail.com with ESMTPSA id s13-20020adfeb0d000000b002fb6a79dea0sm5256391wrn.7.2023.04.21.14.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 14:15:13 -0700 (PDT)
Date:   Fri, 21 Apr 2023 22:15:12 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [RFC PATCH 3/3] mm: perform the mapping_map_writable() check
 after call_mmap()
Message-ID: <44519d2e-8c26-4418-863f-7459d5adbc45@lucifer.local>
References: <cover.1680560277.git.lstoakes@gmail.com>
 <c814a3694f09896e4ec85cbca74069ea6174ebb6.1680560277.git.lstoakes@gmail.com>
 <20230421090628.347b6qojxvfsgoqk@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421090628.347b6qojxvfsgoqk@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 21, 2023 at 11:06:28AM +0200, Jan Kara wrote:
> On Mon 03-04-23 23:28:32, Lorenzo Stoakes wrote:
> > In order for a F_SEAL_WRITE sealed memfd mapping to have an opportunity to
> > clear VM_MAYWRITE, we must be able to invoke the appropriate vm_ops->mmap()
> > handler to do so. We would otherwise fail the mapping_map_writable() check
> > before we had the opportunity to avoid it.
> >
> > This patch moves this check after the call_mmap() invocation. Only memfd
> > actively denies write access causing a potential failure here (in
> > memfd_add_seals()), so there should be no impact on non-memfd cases.
> >
> > This patch makes the userland-visible change that MAP_SHARED, PROT_READ
> > mappings of an F_SEAL_WRITE sealed memfd mapping will now succeed.
> >
> > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> > ---
> >  mm/mmap.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index c96dcce90772..a166e9f3c474 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -2596,17 +2596,17 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  	vma->vm_pgoff = pgoff;
> >
> >  	if (file) {
> > -		if (is_shared_maywrite(vm_flags)) {
> > -			error = mapping_map_writable(file->f_mapping);
> > -			if (error)
> > -				goto free_vma;
> > -		}
> > -
> >  		vma->vm_file = get_file(file);
> >  		error = call_mmap(file, vma);
> >  		if (error)
> >  			goto unmap_and_free_vma;
> >
> > +		if (vma_is_shared_maywrite(vma)) {
> > +			error = mapping_map_writable(file->f_mapping);
> > +			if (error)
> > +				goto unmap_and_free_vma;
>
> Shouldn't we rather jump to close_and_free_vma?

You're right, we may need to call vma->vm_ops->close() to match the
->mmap().

>
> 								Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
