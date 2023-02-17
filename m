Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503B369AF59
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Feb 2023 16:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjBQPTH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Feb 2023 10:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjBQPTF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Feb 2023 10:19:05 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450DF718D4
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Feb 2023 07:19:01 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id ez12so5533214edb.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Feb 2023 07:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FU0XLrtzMAKjlRYy7HgclTRxusFFqyOt4HUxHYauwNc=;
        b=ClA2++cyEmWIvrCX/JLkk1qEq68q05a7YodtcNV8zGQp1BNgn63XDxPeGO7ySUcDYu
         d/BePzI2UZKdbMBHeF/uusiEID2WsgF/lI0ZO0877Ps7RzA86sMfjjc1Z3Khofm4S0v8
         KkPGTDYEIR3Dxr25JpZ4QoJAXrpm2d2qU343QGPZOx/rqhd+s5q4LvOrP06XV3EobMI4
         Y0Y5hq1fKFB9aU2sdTAL7uSoo9pGWeekuKrycc5FhIEWiP/VLCsAayu90Nvtw+OYrhBN
         L8xmKmDLgZpok4Nfhs2ZMXm6azC0AeyitLgDGNi3iJS2nEB4vZskhWphpKChMmYyxShV
         RLMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FU0XLrtzMAKjlRYy7HgclTRxusFFqyOt4HUxHYauwNc=;
        b=KnkvmDuJCAnS1omO93Lm2hdCuiKI2DA7wKMqkZGOhUFt1F9Nc+E4cxghOYzvIQNfPN
         T5l+uNW+7Wxxw7K1m9xuoqHx0VAgyddmB4VmIJExYuVZ+uUDh1SVdZV3/I6F4TvfmICB
         5dILtRI66c32mlSvvvd/S5K9C7Ft7EHajzfP87NhLTj1A6rV7IisVMS0+FWN33kTzs9H
         DJqwLV3BR06+KExdAF3if9LlT0JGtY8oEdRGAnhTXC6EJv3qY7EgrI1TXVf/z0NtLgOm
         FCV0qgt4Zzkq5PatwcDkpXiIltt0/g6TcozBHNSzyzdeKQ3ux+Yz4KddO2BZiFpPRgRY
         cBQA==
X-Gm-Message-State: AO0yUKUJKQjeBy7B5Lc3lvqB6uXjljDJbbuIpkzJjV2MTICn2Y118lWY
        EcPuZJhFYWap0DTYTyWNpsx0d1qXge7jcDGUJEsekw==
X-Google-Smtp-Source: AK7set+sX96S/Lh1UKWLv7UWH9jx5/d5nrpnfKpxlGGC/JiPWb4tlRxD5PVoIjiClVPuLTYAaerKW4sYVYIH/ehhHR0=
X-Received: by 2002:a17:906:48c9:b0:8ae:9f1e:a1c5 with SMTP id
 d9-20020a17090648c900b008ae9f1ea1c5mr525133ejt.3.1676647139268; Fri, 17 Feb
 2023 07:18:59 -0800 (PST)
MIME-Version: 1.0
References: <20230202112915.867409-1-usama.anjum@collabora.com> <20230202112915.867409-4-usama.anjum@collabora.com>
In-Reply-To: <20230202112915.867409-4-usama.anjum@collabora.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Fri, 17 Feb 2023 16:18:47 +0100
Message-ID: <CABb0KFEgsk+YidSXBYQ9mM8nVV6PuEOQf=bbNn7hsoG1hUeLZg@mail.gmail.com>
Subject: Re: [PATCH v10 3/6] fs/proc/task_mmu: Implement IOCTL to get and/or
 the clear info about PTEs
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2 Feb 2023 at 12:30, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
[...]
> - The masks are specified in required_mask, anyof_mask, excluded_ mask
>   and return_mask.
[...]

May I suggest a slightly modified interface for the flags?

As I understand, the return_mask is what is applied to page flags to
aggregate the list.
This is a separate thing, and I think it doesn't need changes except
maybe an improvement
in the documentation and visual distinction.

For the page-selection mechanism, currently required_mask and
excluded_mask have conflicting
responsibilities. I suggest to rework that to:
1. negated_flags: page flags which are to be negated before applying
the page selection using following masks;
2. required_flags: flags which all have to be set in the
(negation-applied) page flags;
3. anyof_flags: flags of which at least one has to be set in the
(negation-applied) page flags;

IOW, the resulting algorithm would be:

tested_flags =3D page_flags ^ negated_flags;
if (~tested_flags & required_flags)
  skip page;
if (!(tested_flags & anyof_flags))
  skip_page;

aggregate_on(page_flags & return_flags);

Best Regards
Micha=C5=82 Miros=C5=82aw
