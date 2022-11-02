Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72822615E70
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 09:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbiKBIzT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 04:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbiKBIzQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 04:55:16 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C768824969;
        Wed,  2 Nov 2022 01:55:14 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id t26so7319373uaj.9;
        Wed, 02 Nov 2022 01:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8u/qv2jL7ReMKujRrkoVq2CcT03zgxq0ws72lCTuzcE=;
        b=cigxBDHVD5ZANzyZnqhwPRfDQXKs7vIPENgo4sVS15AuaCwDJwd0xTEFSWPfe1MiM4
         mRMmzPFIV6PP9bFMV6hxloONA7XZpxxbvD3cjkHDblo/AfO5Bedv9jk6T0R0U1bGX5l5
         yJfDujMpQf7TsXpnxPWrBPF9U0JyPwl7FUexm8H1D8c3buhOwOBh8dt4EcDXIocZSSAc
         dWSQEL+N8gsVjMWxdTb0U75SKji7qcn77qTAsSOF/FV5crfAo1mmBPOY1+FaMfQhbBZl
         QuIBjq1ZQqMcZyOxhbtPSthpAWwz6eT/lrXi9Y+ThHxG+ZymU/smOXqM9Hjw4+GztF4X
         n8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8u/qv2jL7ReMKujRrkoVq2CcT03zgxq0ws72lCTuzcE=;
        b=4mtNhFploAQyQWBWYKp7T6wfLEJ6VgwpbSFDvMlzv9JhCcel+kA8tdHcA4pgNua/yN
         2CLFX3IJb4rCT2Ys3miZ/qnfc6lHDpzWRPNzTcwzWr8uYNGidKR3yd8Pb/0/Ppv9aLKF
         GxTgd2U22duhqD0xiQsB57SOeHZg9MYRNI3/GqCNucHPPhoGVxciHTB22wqW/JnBVkcn
         mxHeA6YpymRzmgyeU2AoMOjhYrv+G/RGuU6av43QTJ1ORPieIzL2TvQ1GLpj3iyzlTi3
         skiQVVCKJiEIJYjpRk3oht4xUS6HnQOg/hkA4bImrNOXe+gleo1MW+D18bNH+cGoCgl2
         kGcA==
X-Gm-Message-State: ACrzQf20sP9mT8RF0Dwu9IsU7VMfCx3akdnxWFMhijasLSqS90HsQc16
        trm7LKfL2oEm0GVsjveeJZglkgbWlB4g29uoniMljMEr0ws=
X-Google-Smtp-Source: AMsMyM7IW3PUzanzE/XszM1Kht1BLGAqcgq7lkq1MuFp3giWdOfX7MBmSPXP2W/0Kqy9aW5bHIuuxHmmJXCNxL5GX2E=
X-Received: by 2002:ab0:7395:0:b0:40d:644c:a884 with SMTP id
 l21-20020ab07395000000b0040d644ca884mr8199900uap.9.1667379313761; Wed, 02 Nov
 2022 01:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <20221021010310.29521-1-stephen.s.brennan@oracle.com>
 <20221028001016.332663-1-stephen.s.brennan@oracle.com> <20221101175144.yu3l5qo5gfwfpatt@quack3>
 <877d0eh03t.fsf@oracle.com>
In-Reply-To: <877d0eh03t.fsf@oracle.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 2 Nov 2022 10:55:01 +0200
Message-ID: <CAOQ4uxgG=E+3CwpQAE__YGt7vdW77n0nTe6cExPTERBNUN0a0g@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] fsnotify: fix softlockups iterating over d_subdirs
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: multipart/mixed; boundary="000000000000b3fafc05ec78ff3b"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000b3fafc05ec78ff3b
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 1, 2022 at 10:49 PM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> Hi Jan,
>
> Jan Kara <jack@suse.cz> writes:
> > Hi Stephen!
> >
> > On Thu 27-10-22 17:10:13, Stephen Brennan wrote:
> >> Here is v3 of the patch series. I've taken all of the feedback,
> >> thanks Amir, Christian, Hilf, et al. Differences are noted in each
> >> patch.
> >>
> >> I caught an obvious and silly dentry reference leak: d_find_any_alias()
> >> returns a reference, which I never called dput() on. With that change, I
> >> no longer see the rpc_pipefs issue, but I do think I need more testing
> >> and thinking through the third patch. Al, I'd love your feedback on that
> >> one especially.
> >>
> >> Thanks,
> >> Stephen
> >>
> >> Stephen Brennan (3):
> >>   fsnotify: Use d_find_any_alias to get dentry associated with inode
> >>   fsnotify: Protect i_fsnotify_mask and child flags with inode rwsem
> >>   fsnotify: allow sleepable child flag update
> >
> > Thanks for the patches Stephen and I'm sorry for replying somewhat late.
>
> Absolutely no worries, these things take time. Thanks for taking a look!
>
> > The first patch is a nobrainer. The other two patches ... complicate things
> > somewhat more complicated than I'd like. I guess I can live with them if we
> > don't find a better solution but I'd like to discuss a bit more about
> > alternatives.
>
> Understood!
>
> > So what would happen if we just clear DCACHE_FSNOTIFY_PARENT_WATCHED in
> > __fsnotify_parent() for the dentry which triggered the event and does not
> > have watched parent anymore and never bother with full children walk? I
> > suppose your contention problems will be gone, we'll just pay the price of
> > dget_parent() + fsnotify_inode_watches_children() for each child that
> > falsely triggers instead of for only one. Maybe that's not too bad? After
> > all any event upto this moment triggered this overhead as well...
>
> This is an interesting idea. It came across my mind but I don't think I
> considered it seriously because I assumed that it was too big a change.
> But I suppose in the process I created an even bigger change :P
>
> The false positive dget_parent() + fsnotify_inode_watches_children()
> shouldn't be too bad. I could see a situation where there's a lot of
> random accesses within a directory, where the dget_parent() could cause
> some contention over the parent dentry. But to be fair, the performance
> would have been the same or worse while fsnotify was active in that
> case, and the contention would go away as most of the dentries get their
> flags cleared. So I don't think this is a problem.
>

I also don't think that is a problem.

> > Am I missing something?
>
> I think there's one thing missed here. I understand you'd like to get
> rid of the extra flag in the connector. But the advantage of the flag is
> avoiding duplicate work by saving a bit of state. Suppose that a mark is
> added to a connector, which causes fsnotify_inode_watches_children() to
> become true. Then, any subsequent call to fsnotify_recalc_mask() must
> call __fsnotify_update_child_dentry_flags(), even though the child
> dentry flags don't need to be updated: they're already set. For (very)
> large directories, this can take a few seconds, which means that we're
> doing a few extra seconds of work each time a new mark is added to or
> removed from a connector in that case. I can't imagine that's a super
> common workload though, and I don't know if my customers do that (my
> guess would be no).
>
> For an example of a test workload where this would make a difference:
> one of my test cases is to create a directory with millions of negative
> dentries, and then run "for i in {1..20}; do inotifywait $DIR & done".
> With the series as-is, only the first task needs to do the child flag
> update. With your proposed alternative, each task would re-do the
> update.
>
> If we were to manage to get __fsnotify_update_child_dentry_flags() to
> work correctly, and safely, with the ability to drop the d_lock and
> sleep, then I think that wouldn't be too much of a problem, because then
> other spinlock users of the directory will get a chance to grab it, and
> so we don't risk softlockups. Without the sleepable iterations, it would
> be marginally worse than the current solution, but I can't really
> comment _how_ much worse because like I said, it doesn't sound like a
> frequent usage pattern.
>
> I think I have a _slight_ preference for the current design, but I see
> the appeal of simpler code, and your design would still improve things a
> lot! Maybe Amir has an opinion too, but of course I'll defer to what you
> want.
>

IIUC, patches #1+#3 fix a reproducible softlock, so if Al approves them,
I see no reason to withhold.

With patches #1+#3 applied, the penalty is restricted to adding or
removing/destroying multiple marks on very large dirs or dirs with
many negative dentries.

I think that fixing the synthetic test case of multiple added marks
is rather easy even without DCACHE_FSNOTIFY_PARENT_WATCHED.
Something like the attached patch is what Jan had suggested in the
first place.

The synthetic test case of concurrent add/remove watch on the same
dir may still result in multiple children iterations, but that will usually
not be avoided even with DCACHE_FSNOTIFY_PARENT_WATCHED
and probably not worth optimizing for.

Thoughts?

Thanks,
Amir.

--000000000000b3fafc05ec78ff3b
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="fsnotify-clear-PARENT_WATCHED-flags-lazily.patch"
Content-Disposition: attachment; 
	filename="fsnotify-clear-PARENT_WATCHED-flags-lazily.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l9ze346c0>
X-Attachment-Id: f_l9ze346c0

RnJvbSBjOGVhMWQ4NDM5N2MyNmNlMzM0YmZmOWQ5ZjcyMTQwMGNlYmI4OGRkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBXZWQsIDIgTm92IDIwMjIgMTA6Mjg6MDEgKzAyMDAKU3ViamVjdDogW1BBVENIXSBmc25v
dGlmeTogY2xlYXIgUEFSRU5UX1dBVENIRUQgZmxhZ3MgbGF6aWx5CgpDYWxsIGZzbm90aWZ5X3Vw
ZGF0ZV9jaGlsZHJlbl9kZW50cnlfZmxhZ3MoKSB0byBzZXQgUEFSRU5UX1dBVENIRUQgZmxhZ3MK
b25seSB3aGVuIHBhcmVudCBzdGFydHMgd2F0Y2hpbmcgY2hpbGRyZW4uCgpXaGVuIHBhcmVudCBz
dG9wcyB3YXRjaGluZyBjaGlsZHJlbiwgY2xlYXIgZmFsc2UgcG9zaXRpdmUgUEFSRU5UX1dBVENI
RUQKZmxhZ3MgbGF6aWx5IGluIF9fZnNub3RpZnlfcGFyZW50KCkgZm9yIGVhY2ggYWNjZXNzZWQg
Y2hpbGQuCgpTdWdnZXN0ZWQtYnk6IEphbiBLYXJhIDxqYWNrQHN1c2UuY3o+ClNpZ25lZC1vZmYt
Ynk6IEFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+Ci0tLQogZnMvbm90aWZ5L2Zz
bm90aWZ5LmMgICAgICAgICAgICAgfCAyNiArKysrKysrKysrKysrKysrKysrKy0tLS0tLQogZnMv
bm90aWZ5L2Zzbm90aWZ5LmggICAgICAgICAgICAgfCAgMyArKy0KIGZzL25vdGlmeS9tYXJrLmMg
ICAgICAgICAgICAgICAgIHwgMzIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0KIGlu
Y2x1ZGUvbGludXgvZnNub3RpZnlfYmFja2VuZC5oIHwgIDggKysrKystLS0KIDQgZmlsZXMgY2hh
bmdlZCwgNTYgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMv
bm90aWZ5L2Zzbm90aWZ5LmMgYi9mcy9ub3RpZnkvZnNub3RpZnkuYwppbmRleCAxZTU0MWE5YmQx
MmIuLmY2MDA3OGQ2YmI5NyAxMDA2NDQKLS0tIGEvZnMvbm90aWZ5L2Zzbm90aWZ5LmMKKysrIGIv
ZnMvbm90aWZ5L2Zzbm90aWZ5LmMKQEAgLTEwMywxNyArMTAzLDEzIEBAIHZvaWQgZnNub3RpZnlf
c2JfZGVsZXRlKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IpCiAgKiBwYXJlbnQgY2FyZXMuICBUaHVz
IHdoZW4gYW4gZXZlbnQgaGFwcGVucyBvbiBhIGNoaWxkIGl0IGNhbiBxdWlja2x5IHRlbGwKICAq
IGlmIHRoZXJlIGlzIGEgbmVlZCB0byBmaW5kIGEgcGFyZW50IGFuZCBzZW5kIHRoZSBldmVudCB0
byB0aGUgcGFyZW50LgogICovCi12b2lkIF9fZnNub3RpZnlfdXBkYXRlX2NoaWxkX2RlbnRyeV9m
bGFncyhzdHJ1Y3QgaW5vZGUgKmlub2RlKQordm9pZCBmc25vdGlmeV91cGRhdGVfY2hpbGRyZW5f
ZGVudHJ5X2ZsYWdzKHN0cnVjdCBpbm9kZSAqaW5vZGUsIGJvb2wgd2F0Y2hlZCkKIHsKIAlzdHJ1
Y3QgZGVudHJ5ICphbGlhczsKLQlpbnQgd2F0Y2hlZDsKIAogCWlmICghU19JU0RJUihpbm9kZS0+
aV9tb2RlKSkKIAkJcmV0dXJuOwogCi0JLyogZGV0ZXJtaW5lIGlmIHRoZSBjaGlsZHJlbiBzaG91
bGQgdGVsbCBpbm9kZSBhYm91dCB0aGVpciBldmVudHMgKi8KLQl3YXRjaGVkID0gZnNub3RpZnlf
aW5vZGVfd2F0Y2hlc19jaGlsZHJlbihpbm9kZSk7Ci0KIAlzcGluX2xvY2soJmlub2RlLT5pX2xv
Y2spOwogCS8qIHJ1biBhbGwgb2YgdGhlIGRlbnRyaWVzIGFzc29jaWF0ZWQgd2l0aCB0aGlzIGlu
b2RlLiAgU2luY2UgdGhpcyBpcyBhCiAJICogZGlyZWN0b3J5LCB0aGVyZSBkYW1uIHdlbGwgYmV0
dGVyIG9ubHkgYmUgb25lIGl0ZW0gb24gdGhpcyBsaXN0ICovCkBAIC0xNDAsNiArMTM2LDI0IEBA
IHZvaWQgX19mc25vdGlmeV91cGRhdGVfY2hpbGRfZGVudHJ5X2ZsYWdzKHN0cnVjdCBpbm9kZSAq
aW5vZGUpCiAJc3Bpbl91bmxvY2soJmlub2RlLT5pX2xvY2spOwogfQogCisvKgorICogTGF6aWx5
IGNsZWFyIGZhbHNlIHBvc2l0aXZlIFBBUkVOVF9XQVRDSEVEIGZsYWcgZm9yIGNoaWxkIHdob3Nl
IHBhcmVudCBoYWQKKyAqIHN0b3BwZWQgd2FjdGhpbmcgY2hpbGRyZW4uCisgKi8KK3N0YXRpYyB2
b2lkIGZzbm90aWZ5X3VwZGF0ZV9jaGlsZF9kZW50cnlfZmxhZ3Moc3RydWN0IGlub2RlICppbm9k
ZSwKKwkJCQkJICAgICAgIHN0cnVjdCBkZW50cnkgKmRlbnRyeSkKK3sKKwlzcGluX2xvY2soJmRl
bnRyeS0+ZF9sb2NrKTsKKwkvKgorCSAqIGRfbG9jayBpcyBhIHN1ZmZpY2llbnQgYmFycmllciB0
byBwcmV2ZW50IG9ic2VydmluZyBhIG5vbi13YXRjaGVkCisJICogcGFyZW50IHN0YXRlIGZyb20g
YmVmb3JlIHRoZSBmc25vdGlmeV91cGRhdGVfY2hpbGRyZW5fZGVudHJ5X2ZsYWdzKCkKKwkgKiBv
ciBmc25vdGlmeV91cGRhdGVfZmxhZ3MoKSBjYWxsIHRoYXQgaGFkIHNldCBQQVJFTlRfV0FUQ0hF
RC4KKwkgKi8KKwlpZiAoIWZzbm90aWZ5X2lub2RlX3dhdGNoZXNfY2hpbGRyZW4oaW5vZGUpKQor
CQlkZW50cnktPmRfZmxhZ3MgJj0gfkRDQUNIRV9GU05PVElGWV9QQVJFTlRfV0FUQ0hFRDsKKwlz
cGluX3VubG9jaygmZGVudHJ5LT5kX2xvY2spOworfQorCiAvKiBBcmUgaW5vZGUvc2IvbW91bnQg
aW50ZXJlc3RlZCBpbiBwYXJlbnQgYW5kIG5hbWUgaW5mbyB3aXRoIHRoaXMgZXZlbnQ/ICovCiBz
dGF0aWMgYm9vbCBmc25vdGlmeV9ldmVudF9uZWVkc19wYXJlbnQoc3RydWN0IGlub2RlICppbm9k
ZSwgc3RydWN0IG1vdW50ICptbnQsCiAJCQkJCV9fdTMyIG1hc2spCkBAIC0yMDgsNyArMjIyLDcg
QEAgaW50IF9fZnNub3RpZnlfcGFyZW50KHN0cnVjdCBkZW50cnkgKmRlbnRyeSwgX191MzIgbWFz
aywgY29uc3Qgdm9pZCAqZGF0YSwKIAlwX2lub2RlID0gcGFyZW50LT5kX2lub2RlOwogCXBfbWFz
ayA9IGZzbm90aWZ5X2lub2RlX3dhdGNoZXNfY2hpbGRyZW4ocF9pbm9kZSk7CiAJaWYgKHVubGlr
ZWx5KHBhcmVudF93YXRjaGVkICYmICFwX21hc2spKQotCQlfX2Zzbm90aWZ5X3VwZGF0ZV9jaGls
ZF9kZW50cnlfZmxhZ3MocF9pbm9kZSk7CisJCWZzbm90aWZ5X3VwZGF0ZV9jaGlsZF9kZW50cnlf
ZmxhZ3MocF9pbm9kZSwgZGVudHJ5KTsKIAogCS8qCiAJICogSW5jbHVkZSBwYXJlbnQvbmFtZSBp
biBub3RpZmljYXRpb24gZWl0aGVyIGlmIHNvbWUgbm90aWZpY2F0aW9uCmRpZmYgLS1naXQgYS9m
cy9ub3RpZnkvZnNub3RpZnkuaCBiL2ZzL25vdGlmeS9mc25vdGlmeS5oCmluZGV4IGZkZTc0ZWIz
MzNjYy4uYmNlOWJlMzZkMDZiIDEwMDY0NAotLS0gYS9mcy9ub3RpZnkvZnNub3RpZnkuaAorKysg
Yi9mcy9ub3RpZnkvZnNub3RpZnkuaApAQCAtNzQsNyArNzQsOCBAQCBzdGF0aWMgaW5saW5lIHZv
aWQgZnNub3RpZnlfY2xlYXJfbWFya3NfYnlfc2Ioc3RydWN0IHN1cGVyX2Jsb2NrICpzYikKICAq
IHVwZGF0ZSB0aGUgZGVudHJ5LT5kX2ZsYWdzIG9mIGFsbCBvZiBpbm9kZSdzIGNoaWxkcmVuIHRv
IGluZGljYXRlIGlmIGlub2RlIGNhcmVzCiAgKiBhYm91dCBldmVudHMgdGhhdCBoYXBwZW4gdG8g
aXRzIGNoaWxkcmVuLgogICovCi1leHRlcm4gdm9pZCBfX2Zzbm90aWZ5X3VwZGF0ZV9jaGlsZF9k
ZW50cnlfZmxhZ3Moc3RydWN0IGlub2RlICppbm9kZSk7CitleHRlcm4gdm9pZCBmc25vdGlmeV91
cGRhdGVfY2hpbGRyZW5fZGVudHJ5X2ZsYWdzKHN0cnVjdCBpbm9kZSAqaW5vZGUsCisJCQkJCQkg
IGJvb2wgd2F0Y2hlZCk7CiAKIGV4dGVybiBzdHJ1Y3Qga21lbV9jYWNoZSAqZnNub3RpZnlfbWFy
a19jb25uZWN0b3JfY2FjaGVwOwogCmRpZmYgLS1naXQgYS9mcy9ub3RpZnkvbWFyay5jIGIvZnMv
bm90aWZ5L21hcmsuYwppbmRleCBmY2M2OGI4YTQwZmQuLjYxNGJjZTBlNzI2MSAxMDA2NDQKLS0t
IGEvZnMvbm90aWZ5L21hcmsuYworKysgYi9mcy9ub3RpZnkvbWFyay5jCkBAIC0xNzYsNiArMTc2
LDI0IEBAIHN0YXRpYyB2b2lkICpfX2Zzbm90aWZ5X3JlY2FsY19tYXNrKHN0cnVjdCBmc25vdGlm
eV9tYXJrX2Nvbm5lY3RvciAqY29ubikKIAlyZXR1cm4gZnNub3RpZnlfdXBkYXRlX2lyZWYoY29u
biwgd2FudF9pcmVmKTsKIH0KIAorc3RhdGljIGJvb2wgZnNub3RpZnlfY29ubl93YXRjaGVzX2No
aWxkcmVuKAorCQkJCQlzdHJ1Y3QgZnNub3RpZnlfbWFya19jb25uZWN0b3IgKmNvbm4pCit7CisJ
aWYgKGNvbm4tPnR5cGUgIT0gRlNOT1RJRllfT0JKX1RZUEVfSU5PREUpCisJCXJldHVybiBmYWxz
ZTsKKworCXJldHVybiBmc25vdGlmeV9pbm9kZV93YXRjaGVzX2NoaWxkcmVuKGZzbm90aWZ5X2Nv
bm5faW5vZGUoY29ubikpOworfQorCitzdGF0aWMgdm9pZCBmc25vdGlmeV9jb25uX3NldF9jaGls
ZHJlbl9kZW50cnlfZmxhZ3MoCisJCQkJCXN0cnVjdCBmc25vdGlmeV9tYXJrX2Nvbm5lY3RvciAq
Y29ubikKK3sKKwlpZiAoY29ubi0+dHlwZSAhPSBGU05PVElGWV9PQkpfVFlQRV9JTk9ERSkKKwkJ
cmV0dXJuOworCisJZnNub3RpZnlfdXBkYXRlX2NoaWxkcmVuX2RlbnRyeV9mbGFncyhmc25vdGlm
eV9jb25uX2lub2RlKGNvbm4pLCB0cnVlKTsKK30KKwogLyoKICAqIENhbGN1bGF0ZSBtYXNrIG9m
IGV2ZW50cyBmb3IgYSBsaXN0IG9mIG1hcmtzLiBUaGUgY2FsbGVyIG11c3QgbWFrZSBzdXJlCiAg
KiBjb25uZWN0b3IgYW5kIGNvbm5lY3Rvci0+b2JqIGNhbm5vdCBkaXNhcHBlYXIgdW5kZXIgdXMu
ICBDYWxsZXJzIGFjaGlldmUKQEAgLTE4NCwxNSArMjAyLDIzIEBAIHN0YXRpYyB2b2lkICpfX2Zz
bm90aWZ5X3JlY2FsY19tYXNrKHN0cnVjdCBmc25vdGlmeV9tYXJrX2Nvbm5lY3RvciAqY29ubikK
ICAqLwogdm9pZCBmc25vdGlmeV9yZWNhbGNfbWFzayhzdHJ1Y3QgZnNub3RpZnlfbWFya19jb25u
ZWN0b3IgKmNvbm4pCiB7CisJYm9vbCB1cGRhdGVfY2hpbGRyZW47CisKIAlpZiAoIWNvbm4pCiAJ
CXJldHVybjsKIAogCXNwaW5fbG9jaygmY29ubi0+bG9jayk7CisJdXBkYXRlX2NoaWxkcmVuID0g
IWZzbm90aWZ5X2Nvbm5fd2F0Y2hlc19jaGlsZHJlbihjb25uKTsKIAlfX2Zzbm90aWZ5X3JlY2Fs
Y19tYXNrKGNvbm4pOworCXVwZGF0ZV9jaGlsZHJlbiAmPSBmc25vdGlmeV9jb25uX3dhdGNoZXNf
Y2hpbGRyZW4oY29ubik7CiAJc3Bpbl91bmxvY2soJmNvbm4tPmxvY2spOwotCWlmIChjb25uLT50
eXBlID09IEZTTk9USUZZX09CSl9UWVBFX0lOT0RFKQotCQlfX2Zzbm90aWZ5X3VwZGF0ZV9jaGls
ZF9kZW50cnlfZmxhZ3MoCi0JCQkJCWZzbm90aWZ5X2Nvbm5faW5vZGUoY29ubikpOworCS8qCisJ
ICogU2V0IGNoaWxkcmVuJ3MgUEFSRU5UX1dBVENIRUQgZmxhZ3Mgb25seSBpZiBwYXJlbnQgc3Rh
cnRlZCB3YXRjaGluZy4KKwkgKiBXaGVuIHBhcmVudCBzdG9wcyB3YXRjaGluZywgd2UgY2xlYXIg
ZmFsc2UgcG9zaXRpdmUgUEFSRU5UX1dBVENIRUQKKwkgKiBmbGFncyBsYXppbHkgaW4gX19mc25v
dGlmeV9wYXJlbnQoKS4KKwkgKi8KKwlpZiAodXBkYXRlX2NoaWxkcmVuKQorCQlmc25vdGlmeV9j
b25uX3NldF9jaGlsZHJlbl9kZW50cnlfZmxhZ3MoY29ubik7CiB9CiAKIC8qIEZyZWUgYWxsIGNv
bm5lY3RvcnMgcXVldWVkIGZvciBmcmVlaW5nIG9uY2UgU1JDVSBwZXJpb2QgZW5kcyAqLwpkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9saW51eC9mc25vdGlmeV9iYWNrZW5kLmggYi9pbmNsdWRlL2xpbnV4
L2Zzbm90aWZ5X2JhY2tlbmQuaAppbmRleCBhMzE0MjNjMzc2YTcuLmJkOTBiY2Y2YzNiMCAxMDA2
NDQKLS0tIGEvaW5jbHVkZS9saW51eC9mc25vdGlmeV9iYWNrZW5kLmgKKysrIGIvaW5jbHVkZS9s
aW51eC9mc25vdGlmeV9iYWNrZW5kLmgKQEAgLTU4NiwxMiArNTg2LDE0IEBAIHN0YXRpYyBpbmxp
bmUgX191MzIgZnNub3RpZnlfcGFyZW50X25lZWRlZF9tYXNrKF9fdTMyIG1hc2spCiAKIHN0YXRp
YyBpbmxpbmUgaW50IGZzbm90aWZ5X2lub2RlX3dhdGNoZXNfY2hpbGRyZW4oc3RydWN0IGlub2Rl
ICppbm9kZSkKIHsKKwlfX3UzMiBwYXJlbnRfbWFzayA9IFJFQURfT05DRShpbm9kZS0+aV9mc25v
dGlmeV9tYXNrKTsKKwogCS8qIEZTX0VWRU5UX09OX0NISUxEIGlzIHNldCBpZiB0aGUgaW5vZGUg
bWF5IGNhcmUgKi8KLQlpZiAoIShpbm9kZS0+aV9mc25vdGlmeV9tYXNrICYgRlNfRVZFTlRfT05f
Q0hJTEQpKQorCWlmICghKHBhcmVudF9tYXNrICYgRlNfRVZFTlRfT05fQ0hJTEQpKQogCQlyZXR1
cm4gMDsKIAkvKiB0aGlzIGlub2RlIG1pZ2h0IGNhcmUgYWJvdXQgY2hpbGQgZXZlbnRzLCBkb2Vz
IGl0IGNhcmUgYWJvdXQgdGhlCiAJICogc3BlY2lmaWMgc2V0IG9mIGV2ZW50cyB0aGF0IGNhbiBo
YXBwZW4gb24gYSBjaGlsZD8gKi8KLQlyZXR1cm4gaW5vZGUtPmlfZnNub3RpZnlfbWFzayAmIEZT
X0VWRU5UU19QT1NTX09OX0NISUxEOworCXJldHVybiBwYXJlbnRfbWFzayAmIEZTX0VWRU5UU19Q
T1NTX09OX0NISUxEOwogfQogCiAvKgpAQCAtNjA1LDcgKzYwNyw3IEBAIHN0YXRpYyBpbmxpbmUg
dm9pZCBmc25vdGlmeV91cGRhdGVfZmxhZ3Moc3RydWN0IGRlbnRyeSAqZGVudHJ5KQogCS8qCiAJ
ICogU2VyaWFsaXNhdGlvbiBvZiBzZXR0aW5nIFBBUkVOVF9XQVRDSEVEIG9uIHRoZSBkZW50cmll
cyBpcyBwcm92aWRlZAogCSAqIGJ5IGRfbG9jay4gSWYgaW5vdGlmeV9pbm9kZV93YXRjaGVkIGNo
YW5nZXMgYWZ0ZXIgd2UgaGF2ZSB0YWtlbgotCSAqIGRfbG9jaywgdGhlIGZvbGxvd2luZyBfX2Zz
bm90aWZ5X3VwZGF0ZV9jaGlsZF9kZW50cnlfZmxhZ3MgY2FsbCB3aWxsCisJICogZF9sb2NrLCB0
aGUgZm9sbG93aW5nIGZzbm90aWZ5X3VwZGF0ZV9jaGlsZHJlbl9kZW50cnlfZmxhZ3MgY2FsbCB3
aWxsCiAJICogZmluZCBvdXIgZW50cnksIHNvIGl0IHdpbGwgc3BpbiB1bnRpbCB3ZSBjb21wbGV0
ZSBoZXJlLCBhbmQgdXBkYXRlCiAJICogdXMgd2l0aCB0aGUgbmV3IHN0YXRlLgogCSAqLwotLSAK
Mi4yNS4xCgo=
--000000000000b3fafc05ec78ff3b--
