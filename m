Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246686C2010
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Mar 2023 19:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjCTSio (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 14:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjCTSiX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:38:23 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF285B8A;
        Mon, 20 Mar 2023 11:30:14 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id fm20-20020a05600c0c1400b003ead37e6588so9754409wmb.5;
        Mon, 20 Mar 2023 11:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679337012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DaE8Cq+3HD566AAS3cNbL9kU0VpoY/kWeisZ30TMTT8=;
        b=oA4w6+dDqA8sdlaThxyc3zs7OVUqGgIdMPfb9hG5XtPf9mEQy3/Wr7hm0EwAzKZaIe
         vuOEuEz0WcVfDc00RZMe4OittNI9xbDVeefvoHWrkwHdE8H1IsoKsA8mi8/dq6axQC7u
         FWNEuGqvHzOPhL5WviP7vZvv8DnMrRSxul589MhW/wLoEVNt5hqhMKHt4FWNAnv7TV9l
         QxP/meyuVlI3A9mZ4O4T4nr2SHGTwch1+9hs4D86dh8onYJfn3dpqFX+5B4n/PlqsOAW
         wzRaFP6iKCLKWaVmcUwGbGVLRYwN6+fKF9/jET2Ox/Dz3f//3dVz8WOW/kPj4xi79ipr
         gMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679337012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DaE8Cq+3HD566AAS3cNbL9kU0VpoY/kWeisZ30TMTT8=;
        b=wmYyTPll8EiYsC+3LUxUWXpbVxkVaL/ApsQQR13ok4G/fxE8Q4CT7QQPwBC3jnHReK
         I8dsiTL5hdxoFar/BkUij6wbCY7HOhb5Dr/SjD1x9KpFfqHG84zJ654Ltfjbk0ZyqfH9
         0eyiDP+N/H377NFcLf7hwr/+wXqHhqgnyFTlb3vcmuywukeGrBRkMQt6IgocxDOR+IyC
         Oh2Btiqn+/VLdw5XuOwnyommmFrALGgx6pFOAoV3hktg93cClRa8hJOgWkS7wue6keUV
         xMcA0RaYf6xSRLA9RVxrAwCfWXpbVsJhkirFCw2WRTX9Qu//9Q0J/yaQFqSXQoj5Gwux
         yElw==
X-Gm-Message-State: AO0yUKVAWeD/rly567DHUbFNs6TVOPz1WdLwWDHz1V/iBkdKgVvPNdbp
        7+qoqsMhLU3BLGNY/Tb3/WXAQWvmYx+IW5OKSG8=
X-Google-Smtp-Source: AK7set9Bgwg8JCn7J8ExtyKaKDVaOjrbw73S5bkBKD7eM6hgwNYtQl/5KNokOmDyTHs3W6NUlNefJfPgnBqv6sOyhQU=
X-Received: by 2002:a7b:c7c6:0:b0:3ed:ce50:435a with SMTP id
 z6-20020a7bc7c6000000b003edce50435amr394181wmk.10.1679337011724; Mon, 20 Mar
 2023 11:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230309135718.1490461-1-usama.anjum@collabora.com> <20230309115818.170dd5ef2cde7b58b9354ecd@linux-foundation.org>
In-Reply-To: <20230309115818.170dd5ef2cde7b58b9354ecd@linux-foundation.org>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Mon, 20 Mar 2023 11:30:00 -0700
Message-ID: <CANaxB-wGLbM9U_dK=kzs+r5Xy358aKZ0=J_zODiLOcng+dbXog@mail.gmail.com>
Subject: Re: [PATCH v11 0/7] Implement IOCTL to get and optionally clear info
 about PTEs
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
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
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 9, 2023 at 11:58=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Thu,  9 Mar 2023 18:57:11 +0500 Muhammad Usama Anjum <usama.anjum@coll=
abora.com> wrote:
>
> > The information related to pages if the page is file mapped, present an=
d
> > swapped is required for the CRIU project [5][6]. The addition of the
> > required mask, any mask, excluded mask and return masks are also requir=
ed
> > for the CRIU project [5].
>
> It's a ton of new code and what I'm not seeing in here (might have
> missed it?) is a clear statement of the value of this feature to our
> users.
>
> I see hints that CRIU would like it, but no description of how valuable
> this is to CRIU's users.


Hi Andrew,

The current interface works for CRIU, and I can't say we have anything
critical with it right now.

On the other hand, the new interface has a number of significant improvemen=
ts:

* it is more granular and allows us to track changed pages more
  effectively. The current interface can clear dirty bits for the entire
  process only. In addition, reading info about pages is a separate
  operation. It means we must freeze the process to read information
  about all its pages, reset dirty bits, only then we can start dumping
  pages. The information about pages becomes more and more outdated,
  while we are processing pages. The new interface solves both these
  downsides. First, it allows us to read pte bits and clear the
  soft-dirty bit atomically. It means that CRIU will not need to freeze
  processes to pre-dump their memory. Second, it clears soft-dirty bits
  for a specified region of memory. It means CRIU will have actual info
  about pages to the moment of dumping them.

* The new interface has to be much faster because basic page filtering
  is happening in the kernel. With the old interface, we have to read
  pagemap for each page.


Thanks,
Andrei

>
> So please spend some time preparing this info.
>
> Also, are any other applications of this feature anticipated?  If so,
> what are they?
>
> IOW, please sell this stuff to us!
