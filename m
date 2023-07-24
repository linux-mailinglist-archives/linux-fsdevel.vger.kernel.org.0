Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284D375FB1C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 17:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjGXPrh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 11:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjGXPrg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 11:47:36 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8022210D
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 08:47:35 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fd28ae8b90so103545e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 08:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690213654; x=1690818454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGJt0fnvQ0L+LGrNb0ri+iKmwD6soVF+xq2UtktACoI=;
        b=4ayl5F9QYoKtbj9ejSCAe6UhsDQtWDumTjIRa6JyteLTrQixDSyJcu8+QwHIpx7/WD
         FjsAOnsOXV6PeS3sTMvHBINTyiQlqiPaD4D9wgBhtRctPaqngoOCydp6pgASzhgpFxYC
         bTMNh942B2dLAD14NNBiuDoVGvHvDMOy5I9Bxftp+y7JsZvZzCm2s941mkqXvdG7jR/5
         vbVnSRm6URy4D7RiPPoG6SYNv133htxpDLAO5+Xay9XRAB/lKEgsrbzGD4a+g5a8gIke
         9Fow6CIjIzNnevK8Se1P0j0Qkr8RsVgzi8xF+qL+IPzpgtOJW4/hh4TsnVB2hrsfAJSS
         Ky7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690213654; x=1690818454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cGJt0fnvQ0L+LGrNb0ri+iKmwD6soVF+xq2UtktACoI=;
        b=Fww/nj23XAqhKSYj6GKpDERacFbBiYcqP0wWGkt3E05FcbdrXnUWGgKB8jo2b11La4
         g9q4KcDcQXvkff8dNueHZolgCCCgY/ntrAU2gFAn+Cq0/YU7ty4dSmwsLe1kw+k1bql/
         ttYqcdCi6N3ehjwsJKf0EO4Lk765Ocn3vkoMUIO7G/10JbeWJLUmMB/zow3c/MuQWSQR
         MNkWWPE6cd/v0MXTBBPJQK+4lBK+0UeB+5gV0HWi826GBKncZmasqJ6fZFed3ciw3Tce
         s91o1KYvEHieZLbQOpkKLhkcMfjJ1RzglnhSfIdf9B/daFIj41vQsGlQEl68AHpby2JX
         JK1w==
X-Gm-Message-State: ABy/qLZ2aPgHepNYDYFdkHoEWqApibmGkOpGYDibbQFWHgrIAalwjufU
        co6RjjIxl0TzR3UlDNkq9+P7qdP/Zvk9LF48og2E2A==
X-Google-Smtp-Source: APBJJlEVWgR3a5RNlqNjjZ80QA18DEOUK5VNWJl+Dhumc3ez4S2CtLVOLJKeWZ+0ZmYprXuCkEjt4uP9e6ofjAUA4VQ=
X-Received: by 2002:a05:600c:3546:b0:3f4:2736:b5eb with SMTP id
 i6-20020a05600c354600b003f42736b5ebmr164745wmq.1.1690213653880; Mon, 24 Jul
 2023 08:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230711202047.3818697-1-willy@infradead.org> <20230711202047.3818697-5-willy@infradead.org>
In-Reply-To: <20230711202047.3818697-5-willy@infradead.org>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 24 Jul 2023 17:46:57 +0200
Message-ID: <CAG48ez3jouPFr2j3=06jezeO61qdJNR=eK7OednhCgRU+Y_bYg@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] mm: Move FAULT_FLAG_VMA_LOCK check into handle_pte_fault()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, Arjun Roy <arjunroy@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-fsdevel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 11, 2023 at 10:20=E2=80=AFPM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
> Push the check down from __handle_mm_fault().  There's a mild upside to
> this patch in that we'll allocate the page tables while under the VMA
> lock rather than the mmap lock, reducing the hold time on the mmap lock,
> since the retry will find the page tables already populated.

This commit, by moving the check from __handle_mm_fault() to
handle_pte_fault(), also makes the non-anonymous THP paths (including
the DAX huge fault handling) reachable for VMA-locked faults, right?
Is that intentional?
