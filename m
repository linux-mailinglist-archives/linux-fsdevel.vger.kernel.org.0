Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB8CFDF1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 18:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfD3Qaj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 12:30:39 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40491 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfD3Qa1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 12:30:27 -0400
Received: by mail-lf1-f68.google.com with SMTP id o16so11359821lfl.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2019 09:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YfLhavdIeR7HTTj2ugiDjMzdIxNt+XkZkSlpB23S0bo=;
        b=ktysEAnI5n14hQlp4XgGSlYUe+gWRUC0Vaz3Z++aYo8THpCv7I6G6n5wpMVd3Igco8
         M43PmAC7EpktLexXYxmKwCE0EQ0pqWVzy+Ci8BZCPp8poNWUJdkST03fc/7Htr0eSJzh
         uuvaQyzn+fRrhfkdDSCPCvk2T8Nh9zpGXE7Bia/qi6wLGuVZIXCRcJAd2OlZ98a+WiU1
         idt9G1gRomjoitSez1y1wFs8J2s/F9Nw4q9Ww4lnW5MPtkB8b/uU4Ax75ZbUHbzxjREc
         aUTMA6RzWmIg5x87s5VVYVDO2nG4BrbIV47HTvbQ2d/hdH3u4bzYvYe84GtdVWv9ZQ8P
         529g==
X-Gm-Message-State: APjAAAW6r8AkkEDdhomG1jBs1KI+Q3RxiJk0yogYsl4eDMyejEZkn264
        6I69qP+7Nl8zyLPDWdFiZz1BtmyJkEcpOcZ2P07M7dp7jpI=
X-Google-Smtp-Source: APXvYqya+AxBDyt1yN7Ph2OqZxOECVOXX8/Y3g29YvyTdBMp/HR/PVrs+s2FTZ6J+KDGYR344vrxq41Br3fskMcaBOU=
X-Received: by 2002:a19:a417:: with SMTP id q23mr35897943lfc.110.1556641826091;
 Tue, 30 Apr 2019 09:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190429222613.13345-1-mcroce@redhat.com> <CAGnkfhzkju6LXwHAVCHxCmMvAa1MLQGRY1czE1Boqz2OcEq39Q@mail.gmail.com>
 <CAGXu5j+qejH0c9fG=TwmSyK0FkaiNidgqYZrqgKPf4D_=u2k8A@mail.gmail.com> <20190430160813.GI13796@bombadil.infradead.org>
In-Reply-To: <20190430160813.GI13796@bombadil.infradead.org>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Tue, 30 Apr 2019 18:29:49 +0200
Message-ID: <CAGnkfhxhZ7WELD-w_KA+yKogyyJ=y_=8w+HdpYoiWDbCsQi+zw@mail.gmail.com>
Subject: Re: [PATCH v4] proc/sysctl: add shared variables for range check
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 30, 2019 at 6:08 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Apr 30, 2019 at 08:42:42AM -0700, Kees Cook wrote:
> > On Tue, Apr 30, 2019 at 3:47 AM Matteo Croce <mcroce@redhat.com> wrote:
> > > On Tue, Apr 30, 2019 at 12:26 AM Matteo Croce <mcroce@redhat.com> wrote:
> > > >
> > > > Add a const int array containing the most commonly used values,
> > > > some macros to refer more easily to the correct array member,
> > > > and use them instead of creating a local one for every object file.
> > > >
> > >
> > > Ok it seems that this simply can't be done, because there are at least
> > > two points where extra1,2 are set to a non const struct:
> > > in ip_vs_control_net_init_sysctl() it's assigned to struct netns_ipvs,
> > > while in mpls_dev_sysctl_register() it's assigned to a struct mpls_dev
> > > and a struct net.
> >
> > Why can't these be converted to const also? I don't see the pointer
> > changing anywhere. They're created in one place and never changed.
>
> That's not true; I thought the same thing, but you need to see how
> they're used in the functions they're called.
>
> proc_do_defense_mode(struct ctl_table *table, int write,
>         struct netns_ipvs *ipvs = table->extra2;
>                         update_defense_level(ipvs);
> static void update_defense_level(struct netns_ipvs *ipvs)
>         spin_lock(&ipvs->dropentry_lock);

Indeed. I followed the same code path until I found this:

 167                        ipvs->drop_rate = 0;
 168                        ipvs->sysctl_drop_packet = 1;

so I think that this can't be done like this.

Mind if I send a v5 without the const qualifier? At least to know the
kbuildbot opinion.

Regards,
-- 
Matteo Croce
per aspera ad upstream
