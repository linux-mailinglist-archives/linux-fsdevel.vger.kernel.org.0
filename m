Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355056E504E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 20:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjDQSdk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 14:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjDQSdj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 14:33:39 -0400
X-Greylist: delayed 1484 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 17 Apr 2023 11:33:33 PDT
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B7A10DD;
        Mon, 17 Apr 2023 11:33:32 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:41666)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1poQSt-00AYUx-8R; Mon, 17 Apr 2023 09:08:23 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:35070 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1poQSs-004oqS-3G; Mon, 17 Apr 2023 09:08:22 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <cover.1681508038.git.lstoakes@gmail.com>
        <5a4cf1ebf1c6cdfabbf2f5209facb0180dd20006.1681508038.git.lstoakes@gmail.com>
        <ZD1FECftWekha6Do@nvidia.com>
        <9be77e7e-4531-4e1c-9e0d-4edbb5ad3bd5@lucifer.local>
        <ZD1GrBezHrJTo6x2@nvidia.com>
        <241f0c22-f3d6-436e-a0d8-be04e281ed2f@lucifer.local>
Date:   Mon, 17 Apr 2023 10:07:53 -0500
In-Reply-To: <241f0c22-f3d6-436e-a0d8-be04e281ed2f@lucifer.local> (Lorenzo
        Stoakes's message of "Mon, 17 Apr 2023 14:23:52 +0100")
Message-ID: <87cz427diu.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1poQSs-004oqS-3G;;;mid=<87cz427diu.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/hlfhbMYdh8TSwqCEEto245myqDJhBbl8=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Lorenzo Stoakes <lstoakes@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 572 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.0 (0.7%), b_tie_ro: 2.7 (0.5%), parse: 0.82
        (0.1%), extract_message_metadata: 3.6 (0.6%), get_uri_detail_list:
        1.99 (0.3%), tests_pri_-2000: 2.3 (0.4%), tests_pri_-1000: 4.3 (0.7%),
        tests_pri_-950: 1.01 (0.2%), tests_pri_-900: 0.95 (0.2%),
        tests_pri_-200: 0.67 (0.1%), tests_pri_-100: 8 (1.5%), tests_pri_-90:
        107 (18.8%), check_bayes: 105 (18.3%), b_tokenize: 12 (2.1%),
        b_tok_get_all: 12 (2.1%), b_comp_prob: 2.3 (0.4%), b_tok_touch_all: 76
        (13.2%), b_finish: 0.68 (0.1%), tests_pri_0: 421 (73.5%),
        check_dkim_signature: 0.45 (0.1%), check_dkim_adsp: 3.1 (0.5%),
        poll_dns_idle: 1.64 (0.3%), tests_pri_10: 2.9 (0.5%), tests_pri_500: 9
        (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 3/7] mm/gup: remove vmas parameter from
 get_user_pages_remote()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Lorenzo Stoakes <lstoakes@gmail.com> writes:

> On Mon, Apr 17, 2023 at 10:16:28AM -0300, Jason Gunthorpe wrote:
>> On Mon, Apr 17, 2023 at 02:13:39PM +0100, Lorenzo Stoakes wrote:
>> > On Mon, Apr 17, 2023 at 10:09:36AM -0300, Jason Gunthorpe wrote:
>> > > On Sat, Apr 15, 2023 at 12:27:31AM +0100, Lorenzo Stoakes wrote:
>> > > > The only instances of get_user_pages_remote() invocations which used the
>> > > > vmas parameter were for a single page which can instead simply look up the
>> > > > VMA directly. In particular:-
>> > > >
>> > > > - __update_ref_ctr() looked up the VMA but did nothing with it so we simply
>> > > >   remove it.
>> > > >
>> > > > - __access_remote_vm() was already using vma_lookup() when the original
>> > > >   lookup failed so by doing the lookup directly this also de-duplicates the
>> > > >   code.
>> > > >
>> > > > This forms part of a broader set of patches intended to eliminate the vmas
>> > > > parameter altogether.
>> > > >
>> > > > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
>> > > > ---
>> > > >  arch/arm64/kernel/mte.c   |  5 +++--
>> > > >  arch/s390/kvm/interrupt.c |  2 +-
>> > > >  fs/exec.c                 |  2 +-
>> > > >  include/linux/mm.h        |  2 +-
>> > > >  kernel/events/uprobes.c   | 10 +++++-----
>> > > >  mm/gup.c                  | 12 ++++--------
>> > > >  mm/memory.c               |  9 +++++----
>> > > >  mm/rmap.c                 |  2 +-
>> > > >  security/tomoyo/domain.c  |  2 +-
>> > > >  virt/kvm/async_pf.c       |  3 +--
>> > > >  10 files changed, 23 insertions(+), 26 deletions(-)
>> > > >
>> > > > diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
>> > > > index f5bcb0dc6267..74d8d4007dec 100644
>> > > > --- a/arch/arm64/kernel/mte.c
>> > > > +++ b/arch/arm64/kernel/mte.c
>> > > > @@ -437,8 +437,9 @@ static int __access_remote_tags(struct mm_struct *mm, unsigned long addr,
>> > > >  		struct page *page = NULL;
>> > > >
>> > > >  		ret = get_user_pages_remote(mm, addr, 1, gup_flags, &page,
>> > > > -					    &vma, NULL);
>> > > > -		if (ret <= 0)
>> > > > +					    NULL);
>> > > > +		vma = vma_lookup(mm, addr);
>> > > > +		if (ret <= 0 || !vma)
>> > > >  			break;
>> > >
>> > > Given the slightly tricky error handling, it would make sense to turn
>> > > this pattern into a helper function:
>> > >
>> > > page = get_single_user_page_locked(mm, addr, gup_flags, &vma);
>> > > if (IS_ERR(page))
>> > >   [..]
>> > >
>> > > static inline struct page *get_single_user_page_locked(struct mm_struct *mm,
>> > >    unsigned long addr, int gup_flags, struct vm_area_struct **vma)
>> > > {
>> > > 	struct page *page;
>> > > 	int ret;
>> > >
>> > > 	ret = get_user_pages_remote(*mm, addr, 1, gup_flags, &page, NULL, NULL);
>> > > 	if (ret < 0)
>> > > 	   return ERR_PTR(ret);
>> > > 	if (WARN_ON(ret == 0))
>> > > 	   return ERR_PTR(-EINVAL);
>> > >         *vma = vma_lookup(mm, addr);
>> > > 	if (WARN_ON(!*vma) {
>> > > 	   put_user_page(page);
>> > > 	   return ERR_PTR(-EINVAL);
>> > >         }
>> > > 	return page;
>> > > }
>> > >
>> > > It could be its own patch so this change was just a mechanical removal
>> > > of NULL
>> > >
>> > > Jason
>> > >
>> >
>> > Agreed, I think this would work better as a follow up patch however so as
>> > not to distract too much from the core change.
>>
>> I don't think you should open code sketchy error handling in several
>> places and then clean it up later. Just do it right from the start.
>>
>
> Intent was to do smallest change possible (though through review that grew
> of course), but I see your point, in this instance this is fiddly stuff and
> probably better to abstract it to enforce correct handling.
>
> I'll respin + add something like this.

Could you include in your description why looking up the vma after
getting the page does not introduce a race?

I am probably silly and just looking at this quickly but it does not
seem immediately obvious why the vma and the page should match.

I would not be surprised if you hold the appropriate mutex over the
entire operation but it just isn't apparent from the diff.

I am concerned because it is an easy mistake to refactor something into
two steps and then discover you have introduced a race.

Eric
