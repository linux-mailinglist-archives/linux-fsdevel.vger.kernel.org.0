Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E30A486D75
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jan 2022 23:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245297AbiAFW75 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jan 2022 17:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245153AbiAFW75 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jan 2022 17:59:57 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7196C061245
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jan 2022 14:59:56 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id q25so6589879edb.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jan 2022 14:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wedonS74gSWJnWpiXoYzW3anrg5nrcdUbA3vzIQ0zdg=;
        b=YqDAvXZPBulnnBvCotyMwVEWL6pXP60KznBnmr5m42MhDlzU59XaS7BaCJ+Jm6Jgr0
         0vHrsoBhKD6A4bK8ZwRX5g9nH9BgRpMVOoma7/M8qyJ1UT2Af7lRhjQfSLOgZJlKhJD3
         o7iWCNOa7dUy9yaD5IBTHFYWQQk1d5xgGZofk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wedonS74gSWJnWpiXoYzW3anrg5nrcdUbA3vzIQ0zdg=;
        b=hybwEpy9bg5Vez/UuMSwqf9T6fgK9XkcKNHbCXnjA34d47gUH+damHoKpr9X6ivwFk
         Sqyl8x2h3bpWgiC5jTfBYl6qc4n5hDR68FY/tKUB3Y2fPu60NF1YTuMIhfROYeLbBCPw
         n/fvjIUepUNje0q8Xx3HT7lkRAaWDP8I4EBCrCbDpUDRXEBgmUWGiX6ywRZvWr3pb0vY
         D3UfywNdrpiLDsfbWtb7wvmKk25GScPsxXuX2v/NSP7rjndA/BlqoUOpIhFv8UQQeO0M
         YMIMEAdjiAJvZC1Vl9StHsT2pK+pxYDLX1WPd/jJ3tgP4sCv/Ho3p1BnmOCyh8Tv1CQb
         f1KA==
X-Gm-Message-State: AOAM531g1Kd1HCsu38L7D/0YuzuWK9eVoMC8kQOaDr8QqSvweQIGvtai
        F2TRnn6vt3ugkUxLbEo7Oe7+CFVTOonyAemn
X-Google-Smtp-Source: ABdhPJyYkF2FI7qYR/6if0QUydp/HCXM6DaxP9cTa/W/5E4O1jeJLiUxaGpdpJ/XqF3V6r/bTVaBvA==
X-Received: by 2002:a05:6402:f05:: with SMTP id i5mr17946214eda.258.1641509995133;
        Thu, 06 Jan 2022 14:59:55 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id nd36sm851071ejc.196.2022.01.06.14.59.53
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jan 2022 14:59:53 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id d187-20020a1c1dc4000000b003474b4b7ebcso1325284wmd.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jan 2022 14:59:53 -0800 (PST)
X-Received: by 2002:a7b:c305:: with SMTP id k5mr8692804wmj.144.1641509992696;
 Thu, 06 Jan 2022 14:59:52 -0800 (PST)
MIME-Version: 1.0
References: <000000000000e8f8f505d0e479a5@google.com> <20211211015620.1793-1-hdanton@sina.com>
 <YbQUSlq76Iv5L4cC@sol.localdomain> <YdW3WfHURBXRmn/6@sol.localdomain>
 <CAHk-=wjqh_R9w4-=wfegut2C0Bg=sJaPrayk39JRCkZc=O+gsw@mail.gmail.com>
 <CAHk-=wjddvNbZBuvh9m_2VYFC1W7HvbP33mAzkPGOCHuVi5fJg@mail.gmail.com>
 <CAHk-=wjn5xkLWaF2_4pMVEkZrTA=LiOH=_pQK0g-_BMSE-8Jxg@mail.gmail.com> <YddnuSh15BAGdjAD@slm.duckdns.org>
In-Reply-To: <YddnuSh15BAGdjAD@slm.duckdns.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 6 Jan 2022 14:59:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=whhcoeTOZB_de-Nh28Fy4iNTu2DXzKXEPOubzL36+ME=A@mail.gmail.com>
Message-ID: <CAHk-=whhcoeTOZB_de-Nh28Fy4iNTu2DXzKXEPOubzL36+ME=A@mail.gmail.com>
Subject: Re: psi_trigger_poll() is completely broken
To:     Tejun Heo <tj@kernel.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+cdb5dd11c97cc532efad@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: multipart/mixed; boundary="00000000000002b22d05d4f1d4eb"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--00000000000002b22d05d4f1d4eb
Content-Type: text/plain; charset="UTF-8"

On Thu, Jan 6, 2022 at 2:05 PM Tejun Heo <tj@kernel.org> wrote:
>
> On Wed, Jan 05, 2022 at 11:13:30AM -0800, Linus Torvalds wrote:
> >
> > What are the users? Can we make the rule for -EBUSY simply be that you
> > can _install_ a trigger, but you can't replace an existing one (except
> > with NULL, when you close it).
>
> I don't have enough context here and Johannes seems offline today. Let's
> wait for him to chime in.

Context here:

    https://lore.kernel.org/all/YdW3WfHURBXRmn%2F6@sol.localdomain/

> IIRC, the rationale for the shared trigger at the time was around the
> complexities of preventing it from devolving into O(N) trigger checks on
> every pressure update. If the overriding behavior is something that can be
> changed, I'd prefer going for per-opener triggers even if that involves
> adding complexities (maybe a rbtree w/ prev/next links for faster sweeps?).

So here's a COMPLETELY UNTESTED patch to try to fix the lifetime and locking.

The locking was completely broken, in that psi_trigger_replace()
expected that the caller would hold some exclusive lock so that it
would release the correct previous trigger. The cgroup code doesn't
seem to have any such exclusion.

This (UNTESTED!) patch fixes that breakage by just using a cmpxchg loop.

And the lifetime was completely broken (and that's Eric's email)
because psi_trigger_replace() would drop the refcount to the old
trigger - assuming it got the right one - even though the old trigger
could still have active waiters on the waitqueue due to poll() or
select().

This (UNTESTED!) patch fixes _that_ breakage by making
psi_trigger_replace() instead just put the previous trigger on the
"stale_trigger" linked list, and never release it at all.

It now gets released by "psi_trigger_release()" instead, which walks
the list at file release time. Doing "psi_trigger_replace(.., NULL)"
is not valid any more.

And because the reference cannot go away, we now can throw away all
the incorrect temporary kref_get/put games from psi_trigger_poll(),
which didn't actually fix the race at all, only limited it to the poll
waitqueue.

That also means we can remove the "synchronize_rcu()" from
psi_trigger_destroy(), since that was trying to hide all the problems
with the "take rcu lock and then do kref_get()" thing not having
locking. The locking still doesn't exist, but since we don't release
the old one when replacing it, the issue is moot.

NOTE NOTE NOTE! Not only is this patch entirely untested, there are
optimizations you could do if there was some sane synchronization
between psi_trigger_poll() and psi_trigger_replace(). I put comments
about it in the code, but right now the code just assumes that
replacing a trigger is fairly rare (and since it requires write
permissions, it's not something random users can do).

I'm not proud of this patch, but I think it might fix the fundamental
bugs in the code for now.

It's not lovely, it has room for improvement, and I wish we didn't
need this kind of thing, but it looks superficially sane as a fix to
me.

Comments?

And once again: this is UNTESTED. I've compiled-tested it, it looks
kind of sane to me, but honestly, I don't know the code very well.

Also, I'm not super-happy with how that 'psi_disabled' static branch
works.  If somebody switches it off after it has been on, that will
also disable the freeing code, so now you'll be leaking memory.

I couldn't find it in myself to care.

Eric - you have the test-case, and the eagle-eyes that found this
problem in the first place. As such, your opinion and comments count
more than most...

               Linus

--00000000000002b22d05d4f1d4eb
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_ky3kj4wz0>
X-Attachment-Id: f_ky3kj4wz0

IGluY2x1ZGUvbGludXgvcHNpLmggICAgICAgfCAgMSArCiBpbmNsdWRlL2xpbnV4L3BzaV90eXBl
cy5oIHwgIDMgKysKIGtlcm5lbC9jZ3JvdXAvY2dyb3VwLmMgICAgfCAgMiArLQoga2VybmVsL3Nj
aGVkL3BzaS5jICAgICAgICB8IDcxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0t
LS0tLS0tLS0tLS0tCiA0IGZpbGVzIGNoYW5nZWQsIDU0IGluc2VydGlvbnMoKyksIDIzIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvcHNpLmggYi9pbmNsdWRlL2xpbnV4
L3BzaS5oCmluZGV4IDY1ZWIxNDc2YWM3MC4uOWVjOTQ2OGQ2MDY4IDEwMDY0NAotLS0gYS9pbmNs
dWRlL2xpbnV4L3BzaS5oCisrKyBiL2luY2x1ZGUvbGludXgvcHNpLmgKQEAgLTMzLDYgKzMzLDcg
QEAgdm9pZCBjZ3JvdXBfbW92ZV90YXNrKHN0cnVjdCB0YXNrX3N0cnVjdCAqcCwgc3RydWN0IGNz
c19zZXQgKnRvKTsKIHN0cnVjdCBwc2lfdHJpZ2dlciAqcHNpX3RyaWdnZXJfY3JlYXRlKHN0cnVj
dCBwc2lfZ3JvdXAgKmdyb3VwLAogCQkJY2hhciAqYnVmLCBzaXplX3QgbmJ5dGVzLCBlbnVtIHBz
aV9yZXMgcmVzKTsKIHZvaWQgcHNpX3RyaWdnZXJfcmVwbGFjZSh2b2lkICoqdHJpZ2dlcl9wdHIs
IHN0cnVjdCBwc2lfdHJpZ2dlciAqdCk7Cit2b2lkIHBzaV90cmlnZ2VyX3JlbGVhc2Uodm9pZCAq
KnRyaWdnZXJfcHRyKTsKIAogX19wb2xsX3QgcHNpX3RyaWdnZXJfcG9sbCh2b2lkICoqdHJpZ2dl
cl9wdHIsIHN0cnVjdCBmaWxlICpmaWxlLAogCQkJcG9sbF90YWJsZSAqd2FpdCk7CmRpZmYgLS1n
aXQgYS9pbmNsdWRlL2xpbnV4L3BzaV90eXBlcy5oIGIvaW5jbHVkZS9saW51eC9wc2lfdHlwZXMu
aAppbmRleCAwYTIzMzAwZDQ5YWYuLmVhYjc5ZTY4YmY1NiAxMDA2NDQKLS0tIGEvaW5jbHVkZS9s
aW51eC9wc2lfdHlwZXMuaAorKysgYi9pbmNsdWRlL2xpbnV4L3BzaV90eXBlcy5oCkBAIC0xMzIs
NiArMTMyLDkgQEAgc3RydWN0IHBzaV90cmlnZ2VyIHsKIAogCS8qIFJlZmNvdW50aW5nIHRvIHBy
ZXZlbnQgcHJlbWF0dXJlIGRlc3RydWN0aW9uICovCiAJc3RydWN0IGtyZWYgcmVmY291bnQ7CisK
KwkvKiBQcmV2aW91cyB0cmlnZ2VyIHRoYXQgdGhpcyBvbmUgcmVwbGFjZWQgKi8KKwlzdHJ1Y3Qg
cHNpX3RyaWdnZXIgKnN0YWxlX3RyaWdnZXI7CiB9OwogCiBzdHJ1Y3QgcHNpX2dyb3VwIHsKZGlm
ZiAtLWdpdCBhL2tlcm5lbC9jZ3JvdXAvY2dyb3VwLmMgYi9rZXJuZWwvY2dyb3VwL2Nncm91cC5j
CmluZGV4IDkxOTE5NGRlMzljOC4uODAxZDBhZWMwNDQzIDEwMDY0NAotLS0gYS9rZXJuZWwvY2dy
b3VwL2Nncm91cC5jCisrKyBiL2tlcm5lbC9jZ3JvdXAvY2dyb3VwLmMKQEAgLTM2ODQsNyArMzY4
NCw3IEBAIHN0YXRpYyBfX3BvbGxfdCBjZ3JvdXBfcHJlc3N1cmVfcG9sbChzdHJ1Y3Qga2VybmZz
X29wZW5fZmlsZSAqb2YsCiAKIHN0YXRpYyB2b2lkIGNncm91cF9wcmVzc3VyZV9yZWxlYXNlKHN0
cnVjdCBrZXJuZnNfb3Blbl9maWxlICpvZikKIHsKLQlwc2lfdHJpZ2dlcl9yZXBsYWNlKCZvZi0+
cHJpdiwgTlVMTCk7CisJcHNpX3RyaWdnZXJfcmVsZWFzZSgmb2YtPnByaXYpOwogfQogCiBib29s
IGNncm91cF9wc2lfZW5hYmxlZCh2b2lkKQpkaWZmIC0tZ2l0IGEva2VybmVsL3NjaGVkL3BzaS5j
IGIva2VybmVsL3NjaGVkL3BzaS5jCmluZGV4IDE2NTJmMmJiNTRiNy4uMTA0MzBmNzVmMjFhIDEw
MDY0NAotLS0gYS9rZXJuZWwvc2NoZWQvcHNpLmMKKysrIGIva2VybmVsL3NjaGVkL3BzaS5jCkBA
IC0xMTUyLDYgKzExNTIsNyBAQCBzdHJ1Y3QgcHNpX3RyaWdnZXIgKnBzaV90cmlnZ2VyX2NyZWF0
ZShzdHJ1Y3QgcHNpX2dyb3VwICpncm91cCwKIAl0LT5sYXN0X2V2ZW50X3RpbWUgPSAwOwogCWlu
aXRfd2FpdHF1ZXVlX2hlYWQoJnQtPmV2ZW50X3dhaXQpOwogCWtyZWZfaW5pdCgmdC0+cmVmY291
bnQpOworCXQtPnN0YWxlX3RyaWdnZXIgPSBOVUxMOwogCiAJbXV0ZXhfbG9jaygmZ3JvdXAtPnRy
aWdnZXJfbG9jayk7CiAKQEAgLTEyMjMsMTIgKzEyMjQsNiBAQCBzdGF0aWMgdm9pZCBwc2lfdHJp
Z2dlcl9kZXN0cm95KHN0cnVjdCBrcmVmICpyZWYpCiAKIAltdXRleF91bmxvY2soJmdyb3VwLT50
cmlnZ2VyX2xvY2spOwogCi0JLyoKLQkgKiBXYWl0IGZvciBib3RoICp0cmlnZ2VyX3B0ciBmcm9t
IHBzaV90cmlnZ2VyX3JlcGxhY2UgYW5kCi0JICogcG9sbF90YXNrIFJDVXMgdG8gY29tcGxldGUg
dGhlaXIgcmVhZC1zaWRlIGNyaXRpY2FsIHNlY3Rpb25zCi0JICogYmVmb3JlIGRlc3Ryb3lpbmcg
dGhlIHRyaWdnZXIgYW5kIG9wdGlvbmFsbHkgdGhlIHBvbGxfdGFzawotCSAqLwotCXN5bmNocm9u
aXplX3JjdSgpOwogCS8qCiAJICogU3RvcCBrdGhyZWFkICdwc2ltb24nIGFmdGVyIHJlbGVhc2lu
ZyB0cmlnZ2VyX2xvY2sgdG8gcHJldmVudCBhCiAJICogZGVhZGxvY2sgd2hpbGUgd2FpdGluZyBm
b3IgcHNpX3BvbGxfd29yayB0byBhY3F1aXJlIHRyaWdnZXJfbG9jawpAQCAtMTI0MywxNiArMTIz
OCw0OCBAQCBzdGF0aWMgdm9pZCBwc2lfdHJpZ2dlcl9kZXN0cm95KHN0cnVjdCBrcmVmICpyZWYp
CiAJa2ZyZWUodCk7CiB9CiAKKy8qCisgKiBSZXBsYWNpbmcgYSB0cmlnZ2VyIG11c3Qgbm90IHRo
cm93IGF3YXkgdGhlIG9sZCBvbmUsIHNpbmNlIGl0CisgKiBjYW4gc3RpbGwgaGF2ZSBwZW5kaW5n
IHdhaXRlcnMuCisgKgorICogUG9zc2libGUgb3B0aW1pemF0aW9uOiBhZnRlciBzdWNjZXNzZnVs
bHkgaW5zdGFsbGluZyBhIG5ldworICogdHJpZ2dlciwgd2UgY291bGQgcmVsZWFzZSB0aGUgb2xk
IG9uZSBmcm9tIHRoZSBzdGFsZSBsaXN0CisgKiBlYXJseS4gTm90IGRvbmUgaGVyZSB5ZXQgLSBu
ZWVkcyBsb2NraW5nIHdpdGggcHNpX3RyaWdnZXJfcG9sbC4KKyAqLwogdm9pZCBwc2lfdHJpZ2dl
cl9yZXBsYWNlKHZvaWQgKip0cmlnZ2VyX3B0ciwgc3RydWN0IHBzaV90cmlnZ2VyICpuZXcpCiB7
Ci0Jc3RydWN0IHBzaV90cmlnZ2VyICpvbGQgPSAqdHJpZ2dlcl9wdHI7CisJaWYgKHN0YXRpY19i
cmFuY2hfbGlrZWx5KCZwc2lfZGlzYWJsZWQpKQorCQlyZXR1cm47CisKKwlmb3IgKDs7KSB7CisJ
CXN0cnVjdCBwc2lfdHJpZ2dlciAqb2xkID0gKnRyaWdnZXJfcHRyOworCisJCW5ldy0+c3RhbGVf
dHJpZ2dlciA9IG9sZDsKKwkJaWYgKHRyeV9jbXB4Y2hnKHRyaWdnZXJfcHRyLCBvbGQsIG5ldykp
CisJCQlicmVhazsKKwl9CisKKwkvKgorCSAqIE5vdyB0aGF0IHRoZSBuZXcgb25lIGhhcyBiZWVu
IGluc3RhbGxlZCwgd2UgY291bGQKKwkgKiBjaGVjayBpZiB0aGUgc3RhbGUgb25lIGhhcyBhbiBl
bXB0eSB3YWl0LXF1ZXVlCisJICogYW5kIHJlbGVhc2UgaXQgZWFybHkuLi4gQnV0IHdlJ2QgbmVl
ZCBzb21lIGxvY2tpbmcKKwkgKiB3aXRoIGVudyBwb2xsIHVzZXJzIHRvIGJlIHN1cmUuCisJICov
Cit9CisKKy8qIE5vIGxvY2tpbmcgbmVlZGVkIGZvciBmaW5hbCByZWxlYXNlICovCit2b2lkIHBz
aV90cmlnZ2VyX3JlbGVhc2Uodm9pZCAqKnRyaWdnZXJfcHRyKQoreworCXN0cnVjdCBwc2lfdHJp
Z2dlciAqdHJpZ2dlcjsKIAogCWlmIChzdGF0aWNfYnJhbmNoX2xpa2VseSgmcHNpX2Rpc2FibGVk
KSkKIAkJcmV0dXJuOwogCi0JcmN1X2Fzc2lnbl9wb2ludGVyKCp0cmlnZ2VyX3B0ciwgbmV3KTsK
LQlpZiAob2xkKQotCQlrcmVmX3B1dCgmb2xkLT5yZWZjb3VudCwgcHNpX3RyaWdnZXJfZGVzdHJv
eSk7CisJd2hpbGUgKHRyaWdnZXIpIHsKKwkJc3RydWN0IHBzaV90cmlnZ2VyICpuZXh0ID0gdHJp
Z2dlci0+c3RhbGVfdHJpZ2dlcjsKKwkJa3JlZl9wdXQoJnRyaWdnZXItPnJlZmNvdW50LCBwc2lf
dHJpZ2dlcl9kZXN0cm95KTsKKwkJdHJpZ2dlciA9IG5leHQ7CisJfQogfQogCiBfX3BvbGxfdCBw
c2lfdHJpZ2dlcl9wb2xsKHZvaWQgKip0cmlnZ2VyX3B0ciwKQEAgLTEyNjQsMjQgKzEyOTEsMjQg
QEAgX19wb2xsX3QgcHNpX3RyaWdnZXJfcG9sbCh2b2lkICoqdHJpZ2dlcl9wdHIsCiAJaWYgKHN0
YXRpY19icmFuY2hfbGlrZWx5KCZwc2lfZGlzYWJsZWQpKQogCQlyZXR1cm4gREVGQVVMVF9QT0xM
TUFTSyB8IEVQT0xMRVJSIHwgRVBPTExQUkk7CiAKLQlyY3VfcmVhZF9sb2NrKCk7Ci0KLQl0ID0g
cmN1X2RlcmVmZXJlbmNlKCoodm9pZCBfX3JjdSBfX2ZvcmNlICoqKXRyaWdnZXJfcHRyKTsKLQlp
ZiAoIXQpIHsKLQkJcmN1X3JlYWRfdW5sb2NrKCk7CisJLyoKKwkgKiBTZWUgcHNpX3RyaWdnZXJf
cmVwbGFjZSgpOiBmaW5kaW5nIGEgdHJpZ2dlciBtZWFucworCSAqIHRoYXQgaXQgaXMgZ3VhcmFu
dGVlZCB0byBoYXZlIGFuIGVsZXZhdGVkIHJlZmNvdW50CisJICogZm9yIHRoZSBsaWZldGltZSBv
ZiB0aGlzIGZpbGUgZGVzY3JpcHRvci4KKwkgKgorCSAqIElmIHdlIGhhZCBsb2NraW5nLCB3ZSBj
b3VsZCByZWxlYXNlIGl0IGVhcmx5LiBBcyBpdAorCSAqIGlzLCB3ZSdsbCBvbmx5IHJlbGVhc2Ug
aXQgd2l0aCBwc2lfdHJpZ2dlcl9yZWxlYXNlKCkKKwkgKiBhdCB0aGUgdmVyeSBlbmQuCisJICov
CisJdCA9IFJFQURfT05DRSgqdHJpZ2dlcl9wdHIpOworCWlmICghdCkKIAkJcmV0dXJuIERFRkFV
TFRfUE9MTE1BU0sgfCBFUE9MTEVSUiB8IEVQT0xMUFJJOwotCX0KLQlrcmVmX2dldCgmdC0+cmVm
Y291bnQpOwotCi0JcmN1X3JlYWRfdW5sb2NrKCk7CiAKIAlwb2xsX3dhaXQoZmlsZSwgJnQtPmV2
ZW50X3dhaXQsIHdhaXQpOwogCiAJaWYgKGNtcHhjaGcoJnQtPmV2ZW50LCAxLCAwKSA9PSAxKQog
CQlyZXQgfD0gRVBPTExQUkk7CiAKLQlrcmVmX3B1dCgmdC0+cmVmY291bnQsIHBzaV90cmlnZ2Vy
X2Rlc3Ryb3kpOwotCiAJcmV0dXJuIHJldDsKIH0KIApAQCAtMTM0Nyw3ICsxMzc0LDcgQEAgc3Rh
dGljIGludCBwc2lfZm9wX3JlbGVhc2Uoc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUg
KmZpbGUpCiB7CiAJc3RydWN0IHNlcV9maWxlICpzZXEgPSBmaWxlLT5wcml2YXRlX2RhdGE7CiAK
LQlwc2lfdHJpZ2dlcl9yZXBsYWNlKCZzZXEtPnByaXZhdGUsIE5VTEwpOworCXBzaV90cmlnZ2Vy
X3JlbGVhc2UoJnNlcS0+cHJpdmF0ZSk7CiAJcmV0dXJuIHNpbmdsZV9yZWxlYXNlKGlub2RlLCBm
aWxlKTsKIH0KIAo=
--00000000000002b22d05d4f1d4eb--
