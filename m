Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7AB75FB18
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 17:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjGXPrB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 11:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjGXPrA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 11:47:00 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D563A1B3
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 08:46:59 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fc075d9994so119505e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 08:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690213618; x=1690818418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UReZA49jpXda81AzjPqvcybNIrgPn25JJtMLPfG8EV8=;
        b=DryB/zka48uuJEghAv42rnh8pFDKOLqpwZxUTYvQlc6g0UHvN9GFYYmXnxWIn76a3T
         XTAZF6qHJHhMuw5w9EXg47DV8kZLEIoaXEdjSlNCxhk8/kNSmiXRRU7jZYj77oLsdBW1
         /Fjdxlf0iDqPnUUmTpLUOqWqrjXSJPN0fvj1NFWIaSffYrjMp7tZUJ5mUFlW199X3jy9
         CS9xLNrxPyWxVhw5nVT2rTK5Yyxhp9AyktRg4mevbb8Kk59nDDe2NvWijHg5SHlR5lja
         p8cAV/3uDE8PuSy7HN48HCMeOXonGD48r1m5JPCES02qKjrUk7odtyHHX4Qu6lvYHfxW
         KzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690213618; x=1690818418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UReZA49jpXda81AzjPqvcybNIrgPn25JJtMLPfG8EV8=;
        b=RaJHvCQODeCePUtq2k87P06rWA3hfZ9/kRVuiHKUdYOfh91bUP87k6D577PtrTSYOf
         p2i+qIBjLM2y0DOiogYNMXjT1gGQkcZccL/rC1aWznCJXkZknUQb0grZ4jcqQOSDKnkg
         mQTb3dGGIk0addr1wCEmp6pixtp/et6jyRIfyF3TfZdgI1WNdcZYGPeuWwKXavlv4vp1
         1UOG79H53WND2vK0D4i0oRjnrgqvIcDewHpxHLZxEuUkqNYHlqpVIcDuLIyCyok5bQV9
         O/fFSYYBJeiBI2T5VJTwP8nZx54i2vNXoj0K4XcqBCGZ/q61fs3/lUvabPM5QplCBIry
         h+Ng==
X-Gm-Message-State: ABy/qLaKdRBebpsnZDlNPArYiZ7tKvb8IIEj0kEaSMjHbZ0EfmgI2F17
        HRA92J0z2Toh21dMTraGmRcMFpCpmhJNmN81TVXE2Q==
X-Google-Smtp-Source: APBJJlEORwATYissc1Yk1UYYEygcuNNda+940D3ZL5ecswPuDlAMGqOacpq9oSzkcckEbMEQLkuteNarO6R/MLk2kc8=
X-Received: by 2002:a05:600c:3c93:b0:3fc:75d:8f85 with SMTP id
 bg19-20020a05600c3c9300b003fc075d8f85mr183928wmb.6.1690213618221; Mon, 24 Jul
 2023 08:46:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230711202047.3818697-1-willy@infradead.org> <20230711202047.3818697-6-willy@infradead.org>
In-Reply-To: <20230711202047.3818697-6-willy@infradead.org>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 24 Jul 2023 17:46:21 +0200
Message-ID: <CAG48ez2iccdvgjUh+tTpthJT8rHwd9eJwjgxBFMCWpa+imkQ7w@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] mm: Move FAULT_FLAG_VMA_LOCK check down in handle_pte_fault()
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
> Call do_pte_missing() under the VMA lock ... then immediately retry
> in do_fault().
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
[...]
> @@ -4961,6 +4961,11 @@ static vm_fault_t handle_pte_fault(struct vm_fault=
 *vmf)
>         if (!vmf->pte)
>                 return do_pte_missing(vmf);
>
> +       if ((vmf->flags & FAULT_FLAG_VMA_LOCK) && !vma_is_anonymous(vmf->=
vma)) {
> +               vma_end_read(vmf->vma);
> +               return VM_FAULT_RETRY;
> +       }

At this point we can have vmf->pte mapped, right? Does this mean this
bailout leaks a kmap_local() on CONFIG_HIGHPTE?

>         if (!pte_present(vmf->orig_pte))
>                 return do_swap_page(vmf);
