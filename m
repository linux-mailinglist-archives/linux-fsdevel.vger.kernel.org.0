Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1748A7798ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 22:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235003AbjHKUw3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 16:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236610AbjHKUw2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 16:52:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D2F2D52
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 13:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691787103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T8aVoixM0xxO+gfsUyyhZDp4bChNMHCVGjLRMPROvP8=;
        b=Gn+rQT0Gq+AwJPrFD9UvY28MmsMU5xg+Mvxtref+xtR+bkN/1EaY4OJ7NyE3+9O7MqA14h
        6elkalfDDEaBq6vtm9BhVFa6TRdF7FIos5LUR9Hmz+KKO3QVl02EQqzxbXexIM/6VydlWS
        7E4jKsd4yw3WmHjbiOwGDLvjFx1BAr8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-h8tcE9rZMhOrBlrD0bolpg-1; Fri, 11 Aug 2023 16:51:35 -0400
X-MC-Unique: h8tcE9rZMhOrBlrD0bolpg-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4059b5c3dd0so6198481cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 13:51:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691787095; x=1692391895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8aVoixM0xxO+gfsUyyhZDp4bChNMHCVGjLRMPROvP8=;
        b=DbGjCrw2jpcY6jIYce5QikAg9Jq7f8VUKwR7K1GWMGvp9LO5sJrRGdb24Umc379zJl
         6mo1H5Rb2jAf+SXBOhgLR3UQTbv1/L/pkBssKuqXw0EAMgUW4dvy9A+UmZK1FwNO5KcJ
         KGwhk5nVt6+baDEptZ9l6HFgZg4dCDA1uqmk0+BUEtIyTjDhPAjTVv6JUQYIaurXsGxh
         ZhkW9HbftS2xbOon3kbM2vmCcSxW/PiNvA9nvPLRikt4CD7CsJ/bmI55sZiWUmOzMakW
         pzJlxlUhXpaQSp149746FT2Dlf9wIiDsdWj+wMUBXYHLT2uA7lgNvcNBhQH/B2kx+xqz
         j+Ug==
X-Gm-Message-State: AOJu0YyE9NQTkU0O9fqFkVX7Fjcww+yCCvXZHrRzhPLHpOxnRapMhH+L
        pufGXOcUDEhSRg/extdHZibk7b5A24gXXRs1ZgLZX352JsSvZ5DMavXidv0zpweVy9M2bh0KgM9
        R9y1QW0jcbIQuooH64Lhs3q3fmA==
X-Received: by 2002:a05:6214:3002:b0:63f:7d29:1697 with SMTP id ke2-20020a056214300200b0063f7d291697mr3548987qvb.2.1691787094955;
        Fri, 11 Aug 2023 13:51:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsPsGGsWG+AWvL3NdKiHHIMNHgjAVmUCW2ANACa31+gfznIUk9YVZFCFV5mZXxugGUYOyp/w==
X-Received: by 2002:a05:6214:3002:b0:63f:7d29:1697 with SMTP id ke2-20020a056214300200b0063f7d291697mr3548975qvb.2.1691787094629;
        Fri, 11 Aug 2023 13:51:34 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id f8-20020a0caa88000000b00637873ff0f3sm1479316qvb.15.2023.08.11.13.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 13:51:32 -0700 (PDT)
Date:   Fri, 11 Aug 2023 16:51:30 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Geffon <bgeffon@google.com>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        James Houghton <jthoughton@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "T.J. Alumbaugh" <talumbau@google.com>,
        Yu Zhao <yuzhao@google.com>,
        ZhangPeng <zhangpeng362@huawei.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH mm-unstable fix] mm: userfaultfd: check for start + len
 overflow in validate_range: fix
Message-ID: <ZNafUoITDCuQOTMO@x1n>
References: <20230810192128.1855570-1-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230810192128.1855570-1-axelrasmussen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 10, 2023 at 12:21:28PM -0700, Axel Rasmussen wrote:
> A previous fixup to this commit fixed one issue, but introduced another:
> we're now overly strict when validating the src address for UFFDIO_COPY.
> 
> Most of the validation in validate_range is useful to apply to src as
> well as dst, but page alignment is only a requirement for dst, not src.
> So, split the function up so src can use an "unaligned" variant, while
> still allowing us to share the majority of the code between the
> different cases.
> 
> Reported-by: Ryan Roberts <ryan.roberts@arm.com>
> Closes: https://lore.kernel.org/linux-mm/8fbb5965-28f7-4e9a-ac04-1406ed8fc2d4@arm.com/T/#t
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

