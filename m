Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA1A29A2CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Oct 2020 03:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408253AbgJ0Cy4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 22:54:56 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41483 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389238AbgJ0Cyz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 22:54:55 -0400
Received: by mail-pg1-f195.google.com with SMTP id g12so6395733pgm.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2020 19:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QZF0W4dH550EVE0uGKIEMc2tMXwcFBBpVdPSQqA2FHM=;
        b=2MAHbHx0ohuPXh5dfEpWBJ1Wo1XpSybr0ZIK4nZml41vCIF1vUACcWxDhu7y1Ip5o3
         m0rAzVo+jdRzscmsBgtSK5F2nx6US1AxlWhQAtnUMWANCNouKFShn7mkLrXt07PIt+29
         Ae5VD9TY9vxoo8dkcC9NTOiEL8Jr88c0iFX8/xL9Pn+lGm23m5Rz1+DzuC8XTfFkVtKJ
         6fUnFqiZ1EIcmk31nj/CL5qhZHrS0vi1keWT7Yy464+gAY9EObA83xx5sJFakBU8kQHf
         18UOHryCI9Z/tLR3iV4lE1PlMYz1Txi+ifXGpBBrSLRLHYt0eNPb+u2WnrovgJpikVhS
         0R+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QZF0W4dH550EVE0uGKIEMc2tMXwcFBBpVdPSQqA2FHM=;
        b=FhPGjT5bEpn7glTI64KRa0ALeRDik9FDrgmEHJXXqBx0MP+HYp2EnFSEuaXiuckB2Y
         igHpbAZGlN8JrmOQV8GEH684nTlljffVqhRaKVwLDmuiBCtzUiNIQ+c3QwedS+Fi6QnC
         61boq61CvkWCjWKc+bzLdO5u63M/J9jN3NYAxoODrKjLMggMNlHCORDTlrba6ai79XtQ
         bhOH+AxDhxRWdTLVC0LtqFU9hqDFrWC937nJO6SbVo+q7D7OHSZp6PFGPYOwUddE3IDh
         VlaZIy41Ctx4U0rc4hpm3kXqS/2VKG5u/7ztl1yhSnME85y5OpoBcEc3SSNERijR89RE
         hlDQ==
X-Gm-Message-State: AOAM532+NGsK484R51lCWRDK+8bmGE5WYnPiTjfcQ9/bv3nuPCwokWA/
        3ihpwwWtQlN1/3U4RTQJQwlnD86EQMcyhqWushciog==
X-Google-Smtp-Source: ABdhPJyUXYA2QbO5JVQ8aPVZ/qUZFKpo5APz2TO+UBNlY/I1gMKpDxJkGfjqKKIr9iRX+x23PthAvtxpgrmzfwJVtsM=
X-Received: by 2002:a63:c851:: with SMTP id l17mr21924pgi.31.1603767295050;
 Mon, 26 Oct 2020 19:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <20201026145114.59424-1-songmuchun@bytedance.com> <20201026155351.GS20115@casper.infradead.org>
In-Reply-To: <20201026155351.GS20115@casper.infradead.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 27 Oct 2020 10:54:18 +0800
Message-ID: <CAMZfGtU4VQ08dnxNBsFfxVEnuOZauOhGSLQpi++3fngc_qNqXQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 00/19] Free some vmemmap pages of
 hugetlb page
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 26, 2020 at 11:53 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Oct 26, 2020 at 10:50:55PM +0800, Muchun Song wrote:
> > For tail pages, the value of compound_dtor is the same. So we can reuse
>
> compound_dtor is only set on the first tail page.  compound_head is
> what you mean here, I think.
>

Yes, that's right.  Sorry for the confusion. Thanks.

-- 
Yours,
Muchun
